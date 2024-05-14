//
//  Actor.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct Actor: Mappable {
    var id = 0
    var name = ""
    var birthday: String?
    var place: String?
    var profilePath: String?
    var biography: String?
    var knownFor: String?
    var movieCredits: MovieCredits?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        birthday <- map["birthday"]
        place <- map["place_of_birth"]
        profilePath <- map["profile_path"]
        biography <- map["biography"]
        knownFor <- map["known_for_department"]
        movieCredits <- map["movie_credits"]
    }
}
