//
//  HomeViewModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct HomeViewModel {
    let useCase: HomeUseCaseType
    let navigator: HomeNavigatorType
    let dataSource = BehaviorRelay<[Movie]>(value: [])
    let selectedItem = PublishSubject<Movie>()
}

extension HomeViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: BehaviorRelay<Int>
        let selectedTrigger: Driver<IndexPath>
        let searchTrigger: Driver<Void>
    }
    
    struct  Output {
        let movies: Driver<[Movie]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
       input.loadTrigger
            .asDriver()
            .flatMapLatest { pageIndex in
                return self.useCase.getAllMovie(page: pageIndex)
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
            .drive(onNext: { movies in
                self.dataSource.accept(self.dataSource.value + movies)
            })
            .disposed(by: disposeBag)
        
        input.selectedTrigger
            .withLatestFrom(dataSource.asDriver()) { (indexPath, movies) in
                return movies[indexPath.row]
            }
            .drive(onNext: { movie in
                self.navigator.toMovieDetailScreen(movie: movie)
            })
            .disposed(by: disposeBag)
                
        input.searchTrigger
            .drive(onNext: navigator.toSearchScreen)
            .disposed(by: disposeBag)
        
        return Output(movies: dataSource.asDriver(),
                      error: error.asDriver(),
                      indicator: indicator.asDriver()
        )
    }
}
