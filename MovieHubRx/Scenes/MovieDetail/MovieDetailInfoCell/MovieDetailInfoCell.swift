//
//  MovieDetailInfoCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 15/05/2024.
//

import UIKit
import Reusable

final class MovieDetailInfoCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var backDropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var overViewLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    var onTappedFavorite: ((Bool) -> Void)?
    var onTappedPlay: ((String?) -> Void)?
    private var isFavorited = false
    private var key: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        backDropImageView.addGradientOverlay()
        movieNameLabel.textColor = .white
        descriptionLabel.textColor = .secondaryLabel
        overViewLabel.text = "movie.overview".localized()
        
        posterImageView.do {
            $0.layer.cornerRadius = Constants.cornerImage
            $0.layer.cornerCurve = .continuous
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 3
        }
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        playButton.do {
            $0.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
            $0.tintColor = .white
        }
    }
    
    func bind(movie: Movie, favoriteStatus: Bool) {
        isFavorited = favoriteStatus
        descriptionLabel.text = movie.overview
        movieNameLabel.text = movie.title
        timeLabel.text = String(format: "common.runtime: %@ minutes".localized(),
                                "\(movie.runtime)")
        let voteLabel = movie.voteAverage.toStringRating()
        ratingLabel.text = voteLabel
        
        if let backDropURL = movie.backDropURL {
            backDropImageView.sd_setImage(with: backDropURL)
        }
        
        if let posterURL = movie.posterURL {
            posterImageView.sd_setImage(with: posterURL)
        }
        
        key = movie.videos.results.first?.key
        updateFavoriteButtonImage(isFavorited: isFavorited)
    }
    
    private func updateFavoriteButtonImage(isFavorited: Bool) {
        favoriteButton.tintColor = isFavorited ? .systemPink : .white
    }
    
    @IBAction
    private func tappedFavoriteButton(_ sender: Any) {
        onTappedFavorite?(isFavorited)
    }
    
    @IBAction
    private func tappedPlayButton(_ sender: Any) {
        onTappedPlay?(key)
    }
}
