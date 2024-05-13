//
//  TabBarItemType.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit
import Localize_Swift

enum TabBarItemType {
    case home
    case favorite
    case setting
    
    var item: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: L10n.home,
                                image: Asset.unTappedHome.image,
                                selectedImage: Asset.tappedHome.image.withRenderingMode(.alwaysOriginal))
        case .favorite:
            return UITabBarItem(title: L10n.favorite,
                                image: Asset.unTappedFavorite.image,
                                selectedImage: Asset.tappedFavorite.image.withRenderingMode(.alwaysOriginal))
        case .setting:
            return UITabBarItem(title: L10n.setting,
                                image: Asset.unTappedSetting.image,
                                selectedImage: Asset.tappedSetting.image.withRenderingMode(.alwaysOriginal))
        }
    }
}
