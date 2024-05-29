//
//  MovieDetailViewModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

struct MovieDetailViewModel {
    let useCase: MovieDetailUseCaseType
    let navigator: MovieDetailNavigatorType
    let movie: Movie
}

extension MovieDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectedSimilarTrigger: Driver<Movie>
        let selectedActorTrigger: Driver<Int?>
        let favoritedTrigger: Driver<Bool>
        let playTrigger: Driver<String?>
    }
    
    struct Output {
        let detailsAndFavorited: Driver<[DetailsSectionModel]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        
        let favoriteStatus = BehaviorSubject<Bool>(value: false)
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let addMovie = input.favoritedTrigger
            .filter { !$0 }
            .flatMapLatest { _ -> Driver<Bool> in
                return useCase.addMovie(movie: movie)
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
        
        let deleteMovie = input.favoritedTrigger
            .filter { $0 }
            .flatMapLatest { _ -> Driver<Bool> in
                return useCase.deleteMovie(movieID: movie.id)
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
        
        let statusUpdated = Driver.merge(addMovie, deleteMovie)
            .mapToVoid()
        
        Driver.merge(input.loadTrigger, statusUpdated.asDriver())
            .flatMapLatest {
                return useCase.checkMovieInFavorites(movieID: movie.id)
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
            .drive(onNext: favoriteStatus.onNext(_:))
            .disposed(by: disposeBag)
                    
        let details = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getMovieDetail(id: movie.id)
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
        
        let detailsAndFavorited = Driver.combineLatest(details,
                                                       favoriteStatus.asDriverOnErrorJustComplete())
            .map { movieDetails, isFavorted -> [DetailsSectionModel] in
                let infoItem = SectionItems.info(model: movieDetails, favoriteStatus: isFavorted)
                let castsItem = SectionItems.casts(model: movieDetails.credits ?? Credits())
                let similarItem = SectionItems.similar(model: movieDetails.similar?.results ?? [])
                let items: [SectionItems] = [infoItem, castsItem, similarItem]
                return [.detail(items: items)]
            }
            .asDriver(onErrorJustReturn: [])
        
        input.selectedSimilarTrigger
            .drive(onNext: navigator.toMovieDetail)
            .disposed(by: disposeBag)
        
        input.selectedActorTrigger
            .drive(onNext: navigator.toActorScreen)
            .disposed(by: disposeBag)
        
        input.playTrigger
            .drive(onNext: navigator.toYoutubeTrailer(key:))
            .disposed(by: disposeBag)
        
        return Output(detailsAndFavorited: detailsAndFavorited,
                      error: error.asDriver(),
                      indicator: indicator.asDriver()
        )
    }
}
