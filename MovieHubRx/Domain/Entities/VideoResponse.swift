//
//  VideoResponse.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct VideoResponse {
    var results: [Video]
}

extension VideoResponse {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        results <- map["results"]
    }
}

extension VideoResponse: Mappable {
    init() {
        self.init(
            results: [Video]()
        )
    }
}
