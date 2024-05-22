//
//  UIViewController+Extension.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    func showError(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: L10n.error,
                                   message: message,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.ok, style: .cancel) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func presentSafariViewController(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
