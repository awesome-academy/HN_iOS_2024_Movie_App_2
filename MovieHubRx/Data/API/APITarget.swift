//
//  APITarget.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 15/05/2024.
//

import Foundation
import Moya

enum APITarget {
    case allMovie(page: Int)
    case movieDetail(id: Int)
    case actorDetail(id: Int)
    case search(query: String, page: Int)
}

extension APITarget: TargetType {
    var baseURL: URL {
        let domain = APIUrls.shared.baseUrl
        guard let url = URL(string: domain) else {
            fatalError("Invalid base URL.")
        }
        return url
    }

    var path: String {
        switch self {
        case .allMovie:
            return "/discover/movie"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .actorDetail(let id):
            return "/person/\(id)"
        case .search:
            return "/search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .allMovie, .movieDetail, .actorDetail, .search:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .allMovie(let page):
            return .requestParameters(parameters: ["api_key": APIUrls.shared.key,
                                                   "page": page],
                                      encoding: URLEncoding.queryString)
        case .movieDetail:
            return .requestParameters(parameters: ["api_key": APIUrls.shared.key,
                                                   "append_to_response": "credits,similar,videos"],
                                      encoding: URLEncoding.queryString)
        case .actorDetail:
            return .requestParameters(parameters: ["api_key": APIUrls.shared.key,
                                                   "append_to_response": "movie_credits"],
                                      encoding: URLEncoding.queryString)
        case .search(let query, let page):
            return .requestParameters(parameters: ["api_key": APIUrls.shared.key,
                                                   "query": query,
                                                   "page": page],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .allMovie, .movieDetail, .actorDetail, .search:
            return [
                "Content-type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
}
