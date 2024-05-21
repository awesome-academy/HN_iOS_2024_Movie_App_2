//
//  ActorNavigator.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import Foundation
import UIKit

protocol ActorNavigatorType  {
    func toMovieDetail(_ movie: Movie)
}

struct ActorNavigator: ActorNavigatorType {
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
