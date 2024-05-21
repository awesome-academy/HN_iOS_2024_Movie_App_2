//
//  MovieCollectionViewCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import UIKit
import Reusable

final class MovieCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        posterImageView.layer.cornerRadius = 12
        releaseDateLabel.textColor = .secondaryLabel
    }
    
    func bind(movie: Movie) {
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        if let posterURL = movie.posterURL {
            posterImageView.sd_setImage(with: posterURL)
        }
    }
}
