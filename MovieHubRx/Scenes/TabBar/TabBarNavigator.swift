//
//  TabBarNavigator.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import UIKit

protocol TabBarNavigatorType {
    func createTabBarControllers() -> [UIViewController]
}

struct TabBarNavigator: TabBarNavigatorType {
    
    func createTabBarControllers() -> [UIViewController] {
        let homeVC = makeHome()
        let favoriteVC = makeFavorite()
        let settingVC = makeSetting()
        
        return [homeVC, favoriteVC, settingVC]
    }
    
    private func makeHome() -> UINavigationController {
        let navVC = BaseNavigationController()
        let homeUseCase = HomeUseCase(movieRepository: MovieRepository())
        let homeNavigator = HomeNavigator(navigationController: navVC)
        let homeVM = HomeViewModel(useCase: homeUseCase, navigator: homeNavigator)
        let homeVC = HomeViewController()
        homeVC.bindViewModel(to: homeVM)
        homeVC.tabBarItem = TabBarItemType.home.item
        navVC.viewControllers = [homeVC]
        return navVC
    }
    
    private func makeFavorite() -> UINavigationController {
        let navVC = BaseNavigationController()
        let favoriteUseCase = FavoriteUseCase()
        let favoriteNavigator = FavoriteNavigator(navigationController: navVC)
        let favoriteVM = FavoriteViewModel(useCase: favoriteUseCase, navigator: favoriteNavigator)
        let favoriteVC = FavoriteViewController()
        favoriteVC.bindViewModel(to: favoriteVM)
        favoriteVC.tabBarItem = TabBarItemType.favorite.item
        navVC.viewControllers = [favoriteVC]
        return navVC
    }
    
    private func makeSetting() -> UINavigationController {
        let navVC = BaseNavigationController()
        let settingUseCase = SettingUseCase()
        let settingNavigator = SettingNavigator(navigationController: navVC)
        let settingVM = SettingViewModel(useCase: settingUseCase, navigator: settingNavigator)
        let settingVC = SettingViewController()
        settingVC.bindViewModel(to: settingVM)
        settingVC.tabBarItem = TabBarItemType.setting.item
        navVC.viewControllers = [settingVC]
        return navVC
    }
}
