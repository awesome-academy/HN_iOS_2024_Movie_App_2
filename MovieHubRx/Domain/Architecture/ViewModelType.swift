//
//  ViewModelType.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import RxSwift
import RxCocoa

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output
}
