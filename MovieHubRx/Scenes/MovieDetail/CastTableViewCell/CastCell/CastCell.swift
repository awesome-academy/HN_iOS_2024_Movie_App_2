//
//  CastCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 15/05/2024.
//

import UIKit
import Reusable
import Then

final class CastCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var castImageView: UIImageView!
    @IBOutlet private weak var castNameLabel: UILabel!
    @IBOutlet private weak var originNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        containerView.do {
            $0.layer.cornerRadius = Constants.cornerImage
            $0.layer.cornerCurve = .continuous
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = UIColor.secondaryLabel.cgColor
        }
        
        castImageView.do {
            $0.layer.cornerCurve = .continuous
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.cornerRadius = Constants.cornerImage
        }
        
        castNameLabel.textColor = .secondaryLabel
        originNameLabel.textColor = .secondaryLabel
    }
    
    func bind(info: Cast) {
        if let profileURL = info.profileURL {
            castImageView.sd_setImage(with: profileURL)
        } else {
            castImageView.image = UIImage(named: "default_image")
        }
        castNameLabel.text = info.name
        originNameLabel.text = info.originalName
    }
}
