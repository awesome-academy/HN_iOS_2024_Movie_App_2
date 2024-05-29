//
//  ObservableType+Extension.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

}

extension SharedSequence {
    public func unwrap<Result>() -> SharedSequence<SharingStrategy, Result> where Element == Result? {
        return self.filter { $0 != nil }.compactMap { $0 }
    }
}
