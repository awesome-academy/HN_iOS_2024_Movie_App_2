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
    
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let navigationController: UINavigationController
}
