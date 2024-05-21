//
//  Actor.swift
//  sun-movie
//
//  Created by Duy Nguyễn on 02/05/2024.
//

import Foundation
import ObjectMapper

struct Actor {
    var id: Int
    var name: String
    var birthday: String
    var place: String
    var profilePath: String
    var biography: String
    var knownFor: String
    var movieCredits: MovieCredits
    
    var profileURL: URL? {
        return URL(string: APIUrls.shared.imageUrl + profilePath)
    }
}

extension Actor {
    init?(map: Map) {
        self.init()
    }
    
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

extension Actor: Mappable {
    init() {
        self.init(
            id: 0,
            name: "",
            birthday: "",
            place: "",
            profilePath: "",
            biography: "",
            knownFor: "",
            movieCredits: MovieCredits()
        )
    }
}
