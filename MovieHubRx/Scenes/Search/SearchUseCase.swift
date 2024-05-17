//
//  SearchUseCase.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol SearchUseCaseType {
    func getSearchMovie(query: String, page: Int) -> Observable<[Movie]>
}

struct SearchUseCase: SearchUseCaseType {
    let movieRepository: MovieRepositoryType
    
    func getSearchMovie(query: String, page: Int) -> Observable<[Movie]> {
        return movieRepository.getSearchMovie(query: query, page: page)
    }
}
