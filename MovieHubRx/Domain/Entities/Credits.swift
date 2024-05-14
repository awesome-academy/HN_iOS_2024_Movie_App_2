//
//  Credits.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct Credits: Mappable {
    var id = 0
    var cast = [Cast]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        cast <- map["cast"]
    }
}
