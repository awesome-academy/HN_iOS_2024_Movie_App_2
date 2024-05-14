//
//  HomeUseCase.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeUseCaseType {
    func getAllMovie(page: Int) -> Observable<[Movie]>
}

struct HomeUseCase: HomeUseCaseType {
    var movieRepository: MovieRepositoryType

    func getAllMovie(page: Int) -> Observable<[Movie]> {
        return movieRepository.getMovies(page: page)
    }
}
