//
//  CastTableViewCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 15/05/2024.
//

import UIKit
import Reusable

final class CastTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var castTitle: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageView: UIPageControl!
    
    var tappedCast: ((Cast) -> Void)?
    
    private var dataSource = [Cast]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        castTitle.text = "movie.cast".localized()
        pageView.do {
            $0.isUserInteractionEnabled = false
            $0.currentPageIndicatorTintColor = .white
            $0.pageIndicatorTintColor = .gray
        }
        collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: CastCell.self)
        }
    }
    
    func bind(data: [Cast]) {
        self.dataSource = data
        self.pageView.numberOfPages = data.count
    }
}

extension CastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(for: indexPath, cellType: CastCell.self).then {
            $0.bind(info: dataSource[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedCast?(dataSource[indexPath.row])
    }
}

extension CastTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height - 24)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacingForSection * 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.insetForSection
    }
}

extension CastTableViewCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        pageView.currentPage = indexPath.row
    }
}
