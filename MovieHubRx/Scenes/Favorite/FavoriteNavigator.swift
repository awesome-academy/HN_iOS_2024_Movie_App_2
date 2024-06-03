//
//  FavoriteNavigator.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol FavoriteNavigatorType {
    func toMovieDetail(_ movie: Movie)
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toMovieDetail(_ movie: Movie) {
        let viewController = MovieDetailViewController()
        let useCase = MovieDetailUseCase(movieRepository: MovieRepository())
        let navigator = MovieDetailNavigator(navigationController: navigationController)
        let viewModel = MovieDetailViewModel(useCase: useCase, navigator: navigator, movie: movie)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
