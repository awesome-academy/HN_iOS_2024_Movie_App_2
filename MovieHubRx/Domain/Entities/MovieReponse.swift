//
//  MovieReponse.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct MovieResponse {
    var results: [Movie]
}

extension MovieResponse {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        results <- map["results"]
    }
}

extension MovieResponse: Mappable {
    init() {
        self.init(
            results: [Movie]()
        )
    }
}
