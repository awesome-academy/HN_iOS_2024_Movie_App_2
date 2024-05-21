//
//  ActorUseCase.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol ActorUseCaseType {
    func getActorDetail(id: Int) -> Observable<Actor>
}

struct ActorUseCase: ActorUseCaseType {
    let movieRepository: MovieRepositoryType
    
    func getActorDetail(id: Int) -> Observable<Actor> {
        movieRepository.getActorDetail(id: id)
    }
}
