//
//  TabBarViewModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

struct TabBarViewModel {
    let useCase: TabBarUseCaseType
    let navigator: TabBarNavigatorType
}

extension TabBarViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let viewControllers: Driver<[UIViewController]>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let viewControllers = input.loadTrigger
            .map { _ in
                return self.navigator.createTabBarControllers()
            }
            .asDriver(onErrorJustReturn: [])
        
        return Output(viewControllers: viewControllers)
    }
}
