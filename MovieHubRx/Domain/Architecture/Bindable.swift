//
//  Bindable.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

public protocol Bindable: AnyObject {
    associatedtype ViewModelType
    
    var disposeBag: DisposeBag { get set }
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

public extension Bindable where Self: UIViewController {
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
