//
//  FavoriteUseCase.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoriteUseCaseType {
    func getAllFavorite() -> Observable<[MovieFavorite]>
}

struct FavoriteUseCase: FavoriteUseCaseType {
    let movieRepository: MovieRepositoryType
    
    func getAllFavorite() -> Observable<[MovieFavorite]> {
        return movieRepository.fetchFavoriteMovies()
    }
}
