//
//  HomeNavigator.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit

protocol HomeNavigatorType {
    func toMovieDetailScreen(movie: Movie)
    func toSearchScreen()
}

struct HomeNavigator: HomeNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toMovieDetailScreen(movie: Movie) {
        let viewController = MovieDetailViewController()
        let useCase = MovieDetailUseCase()
        let navigator = MovieDetailNavigator(navigationController: navigationController)
        let viewModel = MovieDetailViewModel(useCase: useCase, navigator: navigator, movie: movie)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toSearchScreen() {
        let viewController = SearchViewController()
        let useCase = SearchUseCase()
        let navigator = SearchNavigator(navigationController: navigationController)
        let viewModel = SearchViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
