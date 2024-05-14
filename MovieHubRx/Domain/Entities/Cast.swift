//
//  Cast.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct Cast: Mappable {
    var id = 0
    var name = ""
    var profilePath: String?
    var originalName: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        profilePath <- map["profile_path"]
        originalName <- map["original_name"]
    }
}
