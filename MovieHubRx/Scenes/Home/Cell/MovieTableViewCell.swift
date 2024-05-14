//
//  MovieTableViewCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import UIKit
import Reusable
import SDWebImage
import Then

final class MovieTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var watchView: GradientView!
    @IBOutlet private weak var watchLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        posterImageView.layer.cornerRadius = 15
        
        rateLabel.do {
            $0.layer.cornerRadius = 5
            $0.textColor = .white
        }
        
        watchView.do {
            $0.layer.cornerRadius = 12
            $0.setColors([.systemIndigo,
                          .systemPurple,
                          .systemMint,
                          .systemPink]
            )
        }
    }
    
    func bind(movie: Movie) {
        let imageUrlString = APIUrls.Endpoint.image(urlString: movie.poster ?? "").url
        posterImageView.sd_setImage(with: URL(string: imageUrlString))
        movieNameLabel.text = movie.title
        let voteLabel = (movie.voteAverage ?? 0.0).toStringRating()
        rateLabel.text = voteLabel
        releaseDateLabel.text = movie.releaseDate
    }
}
