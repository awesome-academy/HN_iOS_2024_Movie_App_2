//
//  FavoriteCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 16/05/2024.
//

import UIKit
import Reusable
import SDWebImage

final class FavoriteCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var rateView: UIView!
    @IBOutlet private weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        containerView.do {
            $0.layer.cornerRadius = Constants.cornerImage
            $0.layer.cornerCurve = .continuous
        }
        movieImageView.layer.cornerRadius = Constants.cornerImage
        rateView.layer.cornerRadius = Constants.cornerImage / 3
    }
    
    func bind(movie: MovieFavorite) {
        let imageUrlString = APIUrls.Endpoint.image(urlString: movie.poster ?? "").url
        movieImageView.sd_setImage(with: URL(string: imageUrlString))
        rateLabel.text = "\(movie.voteAverage)"
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
    }
}
