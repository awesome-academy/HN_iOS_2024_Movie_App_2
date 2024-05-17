//
//  TrailerCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 15/05/2024.
//

import UIKit
import SDWebImage
import Then
import Reusable

final class TrailerCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var backDropImageView: UIImageView!
    @IBOutlet private weak var playImageView: UIImageView!
    @IBOutlet private weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        containerView.do {
            $0.layer.cornerRadius = Constants.cornerImage
            $0.layer.cornerCurve = .continuous
        }
        
        backDropImageView.do {
            $0.layer.cornerRadius = Constants.cornerImage
            $0.layer.cornerCurve = .continuous
        }
    }
    
    func bind(movie: Movie) {
        playImageView.isHidden = true
        if let backDropURL = movie.backDropURL {
            backDropImageView.sd_setImage(with: backDropURL)
        }
        movieName.text = movie.title
    }
}
