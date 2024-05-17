//
//  Credits.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct Credits {
    var id: Int
    var cast: [Cast]
}

extension Credits {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        cast <- map["cast"]
    }
}

extension Credits: Mappable {
    init() {
        self.init(
            id: 0,
            cast: [Cast]()
        )
    }
}
