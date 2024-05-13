//
//  AppNavigator.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import RxSwift
import RxCocoa
import Reusable

protocol AppNavigatorType {
    func toTabBar()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toTabBar() {
        let tabBarNavigator = TabBarNavigator()
        let tabBarUseCase = TabBarUseCase()
        let tabBarVM = TabBarViewModel(useCase: tabBarUseCase, navigator: tabBarNavigator)
        let tabBarVC = TabBarViewController()
        tabBarVC.bindViewModel(to: tabBarVM)
        
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
    }
}
