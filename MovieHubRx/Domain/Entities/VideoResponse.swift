//
//  VideoResponse.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct VideoResponse: Mappable {
    var results = [Video]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        results <- map["results"]
    }
}
