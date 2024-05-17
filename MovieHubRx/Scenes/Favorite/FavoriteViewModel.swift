//
//  FavoriteViewModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct FavoriteViewModel {
    let useCase: FavoriteUseCaseType
    let navigator: FavoriteNavigatorType
}

extension FavoriteViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct  Output {
        
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
   
        return Output()
    }
}
