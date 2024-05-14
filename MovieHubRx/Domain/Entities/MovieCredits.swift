//
//  MovieCredits.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct MovieCredits: Mappable {
    var movies = [Movie]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        movies <- map["cast"]
    }
}
