//
//  UIImageView+Extension.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func addGradientOverlay(startColor: UIColor = .clear, endColor: UIColor = .black) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.5, 1.0]
        layer.addSublayer(gradientLayer)
    }
}
