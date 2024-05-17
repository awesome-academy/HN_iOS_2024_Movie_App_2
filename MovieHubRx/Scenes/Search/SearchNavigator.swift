//
//  SearchNavigator.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import UIKit

protocol SearchNavigatorType {
    func toMovieDetail(_ movie: Movie)
}

struct SearchNavigator: SearchNavigatorType {
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
