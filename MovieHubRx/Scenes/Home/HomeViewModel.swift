//
//  HomeViewModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct HomeViewModel {
    let useCase: HomeUseCaseType
    let navigator: HomeNavigatorType
}

extension HomeViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct  Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
      
        return Output()
    }
}
