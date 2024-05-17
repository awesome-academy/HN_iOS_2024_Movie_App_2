//
//  Cast.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct Cast {
    var id: Int
    var name: String
    var profilePath: String
    var originalName: String
    
    var profileURL: URL? {
        return URL(string: APIUrls.shared.imageUrl + profilePath)
    }
}

extension Cast {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        profilePath <- map["profile_path"]
        originalName <- map["original_name"]
    }
}

extension Cast: Mappable {
    init() {
        self.init(
            id: 0,
            name: "",
            profilePath: "",
            originalName: ""
        )
    }
}
