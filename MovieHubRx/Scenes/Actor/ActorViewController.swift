//
//  ActorViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 21/05/2024.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxDataSources

final class ActorViewController: UIViewController, Bindable, NibReusable, UIScrollViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    typealias DataSource = RxTableViewSectionedReloadDataSource<ActorSectionModel>
    
    var viewModel: ActorViewModel!
    var disposeBag = DisposeBag()
    
    private let loadTrigger = BehaviorSubject<Void>(value: ())
    private let selectMovieTrigger = PublishSubject<Movie>()
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        prepareDataSource()
    }
    
    private func configView() {
        tableView.do {
            $0.register(cellType: ActorInfoCell.self)
            $0.register(cellType: ActorMovieCell.self)
            $0.rx.setDelegate(self)
                .disposed(by: disposeBag)
        }
    }
    
    private func prepareDataSource() {
        dataSource = DataSource(configureCell: configCell)
    }
    
    func bindViewModel() {
        let input = ActorViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ()),
            selectMovieTrigger: selectMovieTrigger.asDriver(onErrorJustReturn: Movie())
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.actorDetail
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

extension ActorViewController {
    private var configCell: DataSource.ConfigureCell {
        return { [weak self] (dataSource, tableView, indexPath, _) in
            switch dataSource[indexPath] {
            case .info(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: ActorInfoCell.self)
                cell.bind(actor: model)
                return cell
            case .actorMovie(let model):
                let cell = tableView.dequeueReusableCell(for: indexPath,
                                                         cellType: ActorMovieCell.self)
                cell.tappedMovie = {
                    guard let self else { return }
                    self.selectMovieTrigger.onNext($0)
                }
                cell.bind(movies: model)
                return cell
            }
        }
    }
}
