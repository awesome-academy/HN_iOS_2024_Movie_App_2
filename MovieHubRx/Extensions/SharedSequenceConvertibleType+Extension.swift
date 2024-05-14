//
//  SharedSequenceConvertibleType+Extension.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType {
    
    public func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}
