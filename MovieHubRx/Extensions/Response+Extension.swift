//
//  Response+Extension.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 15/05/2024.
//

import Foundation
import Foundation
import Moya
import ObjectMapper
import RxSwift

extension Response {
    func mapObject<T: Mappable>(_ type: T.Type) throws -> T {
        guard let json = try mapJSON() as? [String: Any] else {
            throw MoyaError.jsonMapping(self)
        }
        guard let object = T(JSON: json) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

    func mapArray<T: Mappable>(_ type: T.Type) throws -> [T] {
        guard let json = try mapJSON() as? [[String: Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>().mapArray(JSONArray: json)
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapObject<T: Mappable>(_ type: T.Type) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(T.self))
        }
    }

    func mapArray<T: Mappable>(_ type: T.Type) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(T.self))
        }
    }
}
