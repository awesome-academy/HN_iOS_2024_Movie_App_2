//
//  SearchViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

final class SearchViewController: UIViewController, Bindable, NibReusable {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: SearchViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        tableView.do {
            $0.separatorStyle = .none
            $0.rowHeight = Constants.rowHeight
            $0.register(cellType: MovieTableViewCell.self)
        }
    }
    
    func bindViewModel() {
        let input = SearchViewModel.Input(
            searchBarInput: searchBar.rx.text.orEmpty.asDriver(),
            selectTrigger: tableView.rx.itemSelected.asDriver()
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.movies
            .drive(tableView.rx.items) { tableView, index, movie in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
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
