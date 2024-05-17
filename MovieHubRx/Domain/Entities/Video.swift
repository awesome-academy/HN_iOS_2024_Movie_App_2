//
//  Video.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct Video {
    var key: String
    var name: String
}

extension Video {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        key <- map["key"]
        name <- map["name"]
    }
}

extension Video: Mappable {
    init() {
        self.init(
            key: "",
            name: ""
        )
    }
}
