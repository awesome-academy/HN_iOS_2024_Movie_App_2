//
//  FavoriteViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

final class FavoriteViewController: UIViewController, Bindable, NibReusable {
    @IBOutlet private weak var tableView: UITableView!
    private let loadTrigger = PublishSubject<Void>()
    private let pullToRefreshTrigger = PublishSubject<Void>()
    private let refreshControl = UIRefreshControl()
    var viewModel: FavoriteViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        tableView.do {
            $0.rowHeight = Constants.rowHeight
            $0.separatorStyle = .none
            $0.register(cellType: MovieTableViewCell.self)
            $0.addSubview(refreshControl)
        }
        refreshControl.rx.controlEvent(.valueChanged)
            .map { _ in () }
            .bind(to: pullToRefreshTrigger)
            .disposed(by: disposeBag)
    }

    func bindViewModel() {
        let input = FavoriteViewModel.Input(
            loadTrigger: rx.methodInvoked(#selector(viewWillAppear))
                .map { _ in () }
                .asDriverOnErrorJustComplete(),
            selectTrigger: tableView.rx.itemSelected.asDriver(),
            refreshTrigger: pullToRefreshTrigger.asDriverOnErrorJustComplete())

        let output = viewModel.transform(input,
                                         disposeBag: disposeBag)

        output.movies
            .drive(tableView.rx.items) { tableView, index, movie in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.selectionStyle = .none
                cell.bind(movie: movie)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.isRefreshing
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        output.indicator
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: disposeBag)
    }
}   
