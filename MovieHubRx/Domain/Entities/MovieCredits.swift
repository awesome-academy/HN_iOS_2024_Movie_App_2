//
//  MovieCredits.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct MovieCredits {
    var movies: [Movie]
}

extension MovieCredits {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        movies <- map["cast"]
    }
}

extension MovieCredits: Mappable {
    init() {
        self.init(
            movies: [Movie]()
        )
    }
}
