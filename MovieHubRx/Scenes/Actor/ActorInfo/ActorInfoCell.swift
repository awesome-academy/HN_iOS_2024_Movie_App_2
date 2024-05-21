//
//  ActorInfoCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import UIKit
import Reusable
import Then

final class ActorInfoCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var actorImageView: UIImageView!
    @IBOutlet private weak var actorNameLabel: UILabel!
    @IBOutlet private weak var actorBioLabel: UILabel!
    @IBOutlet private weak var actorKnownAsLabel: UILabel!
    @IBOutlet private weak var actorDateLabel: UILabel!
    @IBOutlet private weak var actorPlaceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        actorBioLabel.numberOfLines = 4
        backdropImageView.addGradientOverlay()
        
        actorImageView.do {
            $0.layer.cornerRadius = 12
            $0.layer.cornerCurve = .continuous
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 3
        }
    }
    
    func bind(actor: Actor) {
        actorBioLabel.text = actor.biography
        actorDateLabel.text = "actor.birthday".localized() + actor.birthday
        actorNameLabel.text = actor.name
        actorKnownAsLabel.text = "actor.knownas".localized() +  actor.knownFor
        actorPlaceLabel.text = "actor.place".localized() +  actor.place
        
        if let profileURL = actor.profileURL {
            actorImageView.sd_setImage(with: profileURL)
            backdropImageView.sd_setImage(with: profileURL)
        }
    }
}
