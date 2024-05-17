//
//  Movie.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import ObjectMapper
import Then

struct Movie {
    var id: Int
    var title: String
    var poster: String
    var backDropPath: String
    var releaseDate: String
    var overview: String
    var runtime: Int
    var voteAverage: Double
    var credits: Credits
    var similar: MovieResponse
    var videos: VideoResponse
    
    var backDropURL: URL? {
         return URL(string: APIUrls.shared.imageUrl + backDropPath)
     }
     
     var posterURL: URL? {
         return URL(string: APIUrls.shared.imageUrl + poster)
     }
}

extension Movie {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        poster <- map["poster_path"]
        backDropPath <- map["backdrop_path"]
        releaseDate <- map["release_date"]
        overview <- map["overview"]
        runtime <- map["runtime"]
        voteAverage <- map["vote_average"]
        credits <- map["credits"]
        similar <- map["similar"]
        videos <- map["videos"]
    }
}

extension Movie: Mappable {
    init() {
        self.init(
            id: 0,
            title: "",
            poster: "",
            backDropPath: "",
            releaseDate: "",
            overview: "",
            runtime: 0,
            voteAverage: 0.0,
            credits: Credits(),
            similar: MovieResponse(),
            videos: VideoResponse()
        )
    }
}

extension Movie {
    func mapToMovieFavorite() -> MovieFavorite {
        let favoriteMovie = MovieFavorite(context: CoreDataManager.shared.context)
        favoriteMovie.id = Int32(self.id)
        favoriteMovie.title = self.title
        favoriteMovie.poster = self.poster
        favoriteMovie.backDropPath = self.backDropPath
        favoriteMovie.releaseDate = self.releaseDate
        favoriteMovie.overview = self.overview
        favoriteMovie.runtime = Int32(self.runtime)
        favoriteMovie.voteAverage = self.voteAverage
        return favoriteMovie
    }
}
