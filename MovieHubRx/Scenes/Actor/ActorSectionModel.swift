//
//  ActorSectionModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum ActorSectionModel {
    case detail(items: [ActorItems])
}

enum ActorItems {
    case info(model: Actor)
    case actorMovie(model: [Movie])
}

extension ActorSectionModel: SectionModelType {
    
    typealias Item = ActorItems
    
    var items: [ActorItems] {
        switch self {
        case .detail(let items):
            return items.map { $0 }
        }
    }
    
    init(original: ActorSectionModel, items: [Item]) {
        switch original {
        case .detail:
            self = .detail(items: items)
        }
    }
}
