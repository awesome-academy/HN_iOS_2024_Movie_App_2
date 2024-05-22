//
//  Utils.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 23/05/2024.
//

import Foundation
import UIKit
import SafariServices

func openSafari(from navigationController: UINavigationController, with urlString: String) {
    guard let url = URL(string: urlString) else {
        return
    }
    let safariViewController = SFSafariViewController(url: url)
    navigationController.present(safariViewController, animated: true, completion: nil)
}
