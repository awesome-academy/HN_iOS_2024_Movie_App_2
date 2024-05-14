//
//  Movie.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import ObjectMapper

struct Movie: Mappable {
    var id = 0
    var title = ""
    var poster: String?
    var backDropPath: String?
    var releaseDate: String?
    var overview: String?
    var runtime: Int?
    var voteAverage: Double?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        poster <- map["poster_path"]
        backDropPath <- map["backdrop_path"]
        releaseDate <- map["release_date"]
        overview <- map["overview"]
        runtime <- map["runtime"]
        voteAverage <- map["vote_average"]
    }
}
