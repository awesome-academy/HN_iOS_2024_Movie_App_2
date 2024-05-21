//
//  ActorMovieCell.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import UIKit
import Reusable
import Then

final class ActorMovieCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageView: UIPageControl!
    
    private var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    var tappedMovie: ((Movie) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        titleLabel.text = "actor.list".localized()
        pageView.do {
            $0.isUserInteractionEnabled = false
            $0.currentPageIndicatorTintColor = .white
            $0.pageIndicatorTintColor = .gray
        }
        
        collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: MovieCollectionViewCell.self)
        }
    }
    
    func bind(movies: [Movie]) {
        self.movies = movies
        self.pageView.numberOfPages = movies.count
    }
}

extension ActorMovieCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self).then {
            $0.bind(movie: movies[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedMovie?(movies[indexPath.row])
    }
}

extension ActorMovieCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 290)
    }
}

extension ActorMovieCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        pageView.currentPage = indexPath.row
    }
}
