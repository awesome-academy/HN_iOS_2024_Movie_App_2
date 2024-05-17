//
//  SearchViewModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

struct SearchViewModel {
    let useCase: SearchUseCaseType
    let navigator: SearchNavigatorType
}

extension SearchViewModel: ViewModelType {
    struct Input {
        let searchBarInput: Driver<String>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let movies: Driver<[Movie]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
    
        let movies = input.searchBarInput
            .throttle(.milliseconds(300))
            .filter { !$0.isEmpty }
            .flatMapLatest { query in
                return self.useCase.getSearchMovie(query: query, page: 1)
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
        
        input.selectTrigger
            .withLatestFrom(movies) { indexPath, movies in
                return movies[indexPath.row]
            }
            .drive(onNext: navigator.toMovieDetail)
            .disposed(by: disposeBag)
                
        return Output(movies: movies,
                      error: error.asDriver(),
                      indicator: indicator.asDriver()
        )
    }
}
