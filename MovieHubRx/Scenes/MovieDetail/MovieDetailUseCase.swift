//
//  MovieDetailUseCase.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol MovieDetailUseCaseType {
    func getMovieDetail(id: Int) -> Observable<Movie>
    func checkMovieInFavorites(movieID: Int) -> Observable<Bool>
    func addMovie(movie: Movie) -> Observable<Bool>
    func deleteMovie(movieID: Int) -> Observable<Bool>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let movieRepository: MovieRepositoryType
    
    func getMovieDetail(id: Int) -> Observable<Movie> {
        movieRepository.getMovieDetail(id: id)
    }
    
    func checkMovieInFavorites(movieID: Int) -> Observable<Bool> {
        movieRepository.isMovieInFavorites(movieID: movieID)
    }
    
    func addMovie(movie: Movie) -> Observable<Bool> {
        movieRepository.save(favoriteMovie: movie)
    }
    
    func deleteMovie(movieID: Int) -> Observable<Bool> {
        movieRepository.delete(movieID: movieID)
    }
}
