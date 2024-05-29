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
import CoreData

protocol MovieRepositoryType {
    func getMovies(page: Int) -> Observable<[Movie]>
    func getMovieDetail(id: Int) -> Observable<Movie>
    func getSearchMovie(query: String, page: Int) -> Observable<[Movie]>
    func getActorDetail(id: Int) -> Observable<Actor>
    func save(favoriteMovie: Movie) -> Observable<Bool>
    func delete(movieID: Int) -> Observable<Bool>
    func fetchFavoriteMovies() -> Observable<[Movie]>
    func isMovieInFavorites(movieID: Int) -> Observable<Bool>
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
    
    func save(favoriteMovie: Movie) -> Observable<Bool> {
        let favoriteMovie = favoriteMovie.mapToMovieFavorite()
        return CoreDataManager.shared.save(object: favoriteMovie)
    }
    
    func delete(movieID: Int) -> Observable<Bool> {
        let fetchRequest: NSFetchRequest<MovieFavorite> = MovieFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieID)
        
        return CoreDataManager.shared.fetchObject(request: fetchRequest)
            .flatMap { movieToDelete -> Observable<Bool> in
                guard let movieToDelete = movieToDelete else {
                    return Observable.error(NSError(domain: "",
                                                    code: -1,
                                                    userInfo: [NSLocalizedDescriptionKey: "Movie not found"]))
                }
                return CoreDataManager.shared.delete(object: movieToDelete)
            }
    }
    
    func fetchFavoriteMovies() -> Observable<[Movie]> {
        let fetchRequest: NSFetchRequest<MovieFavorite> = MovieFavorite.fetchRequest()
        return CoreDataManager.shared.fetch(request: fetchRequest)
            .map {  $0.compactMap { $0.toMovie() }}
    }
    
    func isMovieInFavorites(movieID: Int) -> Observable<Bool> {
        let fetchRequest: NSFetchRequest<MovieFavorite> = MovieFavorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieID)
        return CoreDataManager.shared.isObjectExists(request: fetchRequest)
    }
}
