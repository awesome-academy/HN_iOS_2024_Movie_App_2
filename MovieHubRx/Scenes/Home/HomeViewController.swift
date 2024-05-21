//
//  HomeViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

final class HomeViewController: UIViewController, Bindable, NibReusable {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchImageView: UIImageView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchButton: UIButton!
    
    var viewModel: HomeViewModel!
    var disposeBag = DisposeBag()
    
    private let loadTrigger = BehaviorRelay<Int>(value: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        tableView.do {
            $0.delegate = self
            $0.separatorStyle = .none
            $0.rowHeight = Constants.rowHeight
            $0.register(cellType: MovieTableViewCell.self)
        }
        
        searchImageView.addGradientOverlay()
        searchView.do {
            $0.layer.cornerRadius = Constants.cornerImage
            $0.layer.cornerCurve = .continuous
        }
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input(
            loadTrigger: loadTrigger,
            selectedTrigger: tableView.rx.itemSelected.asDriver(),
            searchTrigger: searchButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.movies.drive(tableView.rx.items) { tableView, index, movie in
            let indexPath = IndexPath(item: index, section: 0)
            let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.selectionStyle = .none
            cell.bind(movie: movie)
            return cell
        }
        .disposed(by: disposeBag)
        
        output.indicator
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = tableView.contentOffset.y
        let positionLoadMoreData = tableView.contentSize.height - 100 - scrollView.frame.size.height
        if position > positionLoadMoreData {
            loadTrigger.accept(loadTrigger.value + 1)
        }
    }
}
