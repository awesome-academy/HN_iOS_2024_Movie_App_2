//
//  SettingSectionType.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import Foundation
import UIKit

enum SettingSectionType: Int, CaseIterable {
    case theme
    case language
    case term
    case policy
    
    var image: UIImage? {
        switch self {
        case .theme:
            return Asset.theme.image
        case .language:
            return Asset.language.image
        case .term:
            return Asset.term.image
        case .policy:
            return Asset.policy.image
        }
    }
    
    var title: String {
        switch self {
        case .theme:
            return L10n.theme
        case .language:
            return L10n.language
        case .term:
            return L10n.term
        case .policy:
            return L10n.policy
        }
    }
}
