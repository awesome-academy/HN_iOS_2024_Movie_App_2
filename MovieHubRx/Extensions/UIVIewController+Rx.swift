//
//  UIVIewController+Rx.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import RxSwift
import RxCocoa
import MBProgressHUD

extension Reactive where Base: UIViewController {
    
    var error: Binder<Error> {
        return Binder(base) { viewController, error in
            viewController.showError(message: error.localizedDescription)
        }
    }

    var isLoading: Binder<Bool> {
        return Binder(base) { viewController, isLoading in
            if isLoading {
                let hud = MBProgressHUD.showAdded(to: viewController.view, animated: true)
                hud.offset.y = -30
            } else {
                MBProgressHUD.hide(for: viewController.view, animated: true)
            }
        }
    }
}
