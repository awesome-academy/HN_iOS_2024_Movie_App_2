//
//  MovieDetailNavigator.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import UIKit

protocol MovieDetailNavigatorType {
    func toMovieDetail(_ movie: Movie)
    func toActorScreen(_ castID: Int?)
    func toYoutubeTrailer(key: String?)
}

struct MovieDetailNavigator:  MovieDetailNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toMovieDetail(_ movie: Movie) {
        let viewController = MovieDetailViewController()
        let useCase = MovieDetailUseCase(movieRepository: MovieRepository())
        let navigator = MovieDetailNavigator(navigationController: navigationController)
        let viewModel = MovieDetailViewModel(useCase: useCase, navigator: navigator, movie: movie)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toActorScreen(_ castID: Int?) {
        let viewController = ActorViewController()
        let useCase = ActorUseCase(movieRepository: MovieRepository())
        let navigator = ActorNavigator(navigationController: navigationController)
        let viewModel = ActorViewModel(useCase: useCase, navigator: navigator, actorID: castID)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toYoutubeTrailer(key: String?) {
        let urlString = APIUrls.Endpoint.youtube(urlString: key ?? "").url
        guard let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url)
        else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
