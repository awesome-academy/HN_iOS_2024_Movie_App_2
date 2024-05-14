//
//  MovieRepository.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol MovieRepositoryType {
    func getMovies(page: Int) -> Observable<[Movie]>
    func getMovieDetail(id: Int) -> Observable<Movie>
    func getSearchMovie(query: String, page: Int) -> Observable<[Movie]>
    func getActorDetail(id: Int) -> Observable<Actor>
}

struct MovieRepository: MovieRepositoryType {
    
    func getMovies(page: Int) -> Observable<[Movie]> {
        return APIService.shared.request(.allMovie(page: page))
            .mapObject(MovieResponse.self)
            .asObservable()
            .map {
                $0.results
            }
    }
    
    func getMovieDetail(id: Int) -> Observable<Movie> {
        return APIService.shared.request(.movieDetail(id: id))
            .mapObject(Movie.self)
            .asObservable()
    }
    
    func getSearchMovie(query: String, page: Int) -> Observable<[Movie]> {
        return APIService.shared.request(.search(query: query, page: page))
            .mapObject(MovieResponse.self)
            .asObservable()
            .map {
                $0.results
            }
    }
    
    func getActorDetail(id: Int) -> Observable<Actor> {
        return APIService.shared.request(.actorDetail(id: id))
            .mapObject(Actor.self)
            .asObservable()
    }
}
