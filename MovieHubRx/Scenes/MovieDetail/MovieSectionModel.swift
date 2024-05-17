//
//  MovieSectionModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 15/05/2024.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import RxDataSources

enum DetailsSectionModel {
    case detail(items: [SectionItems])
}

enum SectionItems {
    case info(model: Movie, favoriteStatus: Bool)
    case casts(model: Credits)
    case similar(model: [Movie])
}

extension DetailsSectionModel: SectionModelType {
    
    typealias Item = SectionItems
    
    var items: [SectionItems] {
        switch self {
        case .detail(let items):
            return items.map { $0 }
        }
    }
    
    init(original: DetailsSectionModel, items: [Item]) {
        switch original {
        case .detail:
            self = .detail(items: items)
        }
    }
}

