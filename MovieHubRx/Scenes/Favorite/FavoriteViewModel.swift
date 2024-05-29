//
//  FavoriteViewModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct FavoriteViewModel {
    let useCase: FavoriteUseCaseType
    let navigator: FavoriteNavigatorType
}

extension FavoriteViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
        let refreshTrigger: Driver<Void>
    }
    
    struct  Output {
        let movies: Driver<[Movie]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let isRefreshing: Driver<Bool>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let loadMovies = input.loadTrigger
            .flatMapLatest {
                self.useCase.getAllFavorite()
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
        
        let refreshMovies = input.refreshTrigger
            .flatMapLatest {
                self.useCase.getAllFavorite()
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
        
        let movies = Driver.merge(loadMovies, refreshMovies)
        
        let isRefreshing = refreshMovies
            .map { _ in false }
        
        input.selectTrigger
            .withLatestFrom(movies) { indexPath, movies in
                return movies[indexPath.row]
            }
            .drive(onNext:navigator.toMovieDetail)
            .disposed(by: disposeBag)
                
        return Output(movies: movies,
                      error: error.asDriver(),
                      indicator: indicator.asDriver(),
                      isRefreshing: isRefreshing
        )
    }
}
