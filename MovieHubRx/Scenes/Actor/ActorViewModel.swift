//
//  ActorViewModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct ActorViewModel {
    let useCase: ActorUseCaseType
    let navigator: ActorNavigatorType
    let actorID: Int?
}

extension ActorViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectMovieTrigger: Driver<Movie>
    }
    
    struct Output {
        let actorDetail: Driver<[ActorSectionModel]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let details = input.loadTrigger
            .compactMap { actorID }
            .flatMapLatest { actorID -> Driver<Actor> in
                return self.useCase.getActorDetail(id: actorID)
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }
        
        let actorDetail = details.map { actor -> [ActorSectionModel] in
            let infor = ActorItems.info(model: actor)
            let moviesItem = ActorItems.actorMovie(model: actor.movieCredits.movies)
            return [.detail(items: [infor, moviesItem])]
        }
        
        input.selectMovieTrigger
            .drive(onNext: navigator.toMovieDetail)
            .disposed(by: disposeBag)
        
        return Output(actorDetail: actorDetail,
                      error: error.asDriver(),
                      indicator: indicator.asDriver())
    }
}
