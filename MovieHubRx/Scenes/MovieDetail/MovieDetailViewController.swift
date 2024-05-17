//
//  MovieDetailViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Reusable

final class MovieDetailViewController: UIViewController, Bindable, NibReusable, UIScrollViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    typealias DataSource = RxTableViewSectionedReloadDataSource<DetailsSectionModel>
    var viewModel: MovieDetailViewModel!
    var disposeBag: DisposeBag! = DisposeBag()
    
    private let similarMovie  = PublishSubject<Movie>()
    private let favoriteButtonTrigger = PublishSubject<Bool>()
    private let loadTrigger = BehaviorSubject<Void>(value: ())
    private let playTrigger = PublishSubject<String?>()
    private var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        prepareDataSource()
    }

    private func configView() {
        tableView.do {
            $0.separatorStyle = .none
            $0.register(cellType: MovieDetailInfoCell.self)
            $0.register(cellType: CastTableViewCell.self)
            $0.register(cellType: SimilarTableViewCell.self)
            $0.rx.setDelegate(self)
                .disposed(by: disposeBag)
        }
    }
    
    private func prepareDataSource() {
        dataSource = DataSource(configureCell: configCell)
    }
    
    func bindViewModel() {
        let input = MovieDetailViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ()),
            selectedSimilarTrigger: similarMovie.asDriver(onErrorJustReturn: Movie()),
            favoritedTrigger: favoriteButtonTrigger.asDriver(onErrorJustReturn: false),
            playTrigger: playTrigger.asDriver(onErrorJustReturn: nil)
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.detailsAndFavorited
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        output.indicator
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: disposeBag)
    }
}

extension MovieDetailViewController {
    private var configCell: DataSource.ConfigureCell {
        return { [weak self] (dataSource, tableView, indexPath, _) in
            switch dataSource[indexPath] {
            case .info(let model, let favoriteStatus):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: MovieDetailInfoCell.self)
                cell.onTappedFavorite = { [weak self] in
                    guard let self else { return }
                    self.favoriteButtonTrigger.onNext($0)
                }
                
                cell.onTappedPlay = { [weak self] in
                    guard let self else { return }
                    self.playTrigger.onNext($0)
                }
                cell.bind(movie: model, favoriteStatus: favoriteStatus)
                return cell
                
            case .casts(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: CastTableViewCell.self)
                cell.bind(data: model.cast)
                return cell
                
            case .similar(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: SimilarTableViewCell.self)
                cell.tappedSimilar = { [weak self] in
                    guard let self else { return }
                    self.similarMovie.onNext($0)
                }
                cell.bind(data: model)
                return cell
            }
        }
    }
}
