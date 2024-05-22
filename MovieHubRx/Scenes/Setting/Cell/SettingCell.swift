//
//  SettingCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import UIKit
import Reusable

final class SettingCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var settingImageView: UIImageView!
    @IBOutlet private weak var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        containerView.do {
            $0.layer.cornerRadius = Constants.cornerImage
            $0.layer.cornerCurve = .continuous
        }
    }
    
    func bind(for sectionType: SettingSectionType) {
        settingImageView.image = sectionType.image
        settingLabel.text = sectionType.title
    }
}
