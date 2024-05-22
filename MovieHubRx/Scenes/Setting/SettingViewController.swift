//
//  SettingViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

final class SettingViewController: UIViewController, Bindable, NibReusable {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: SettingViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        tableView.register(cellType: SettingCell.self)
    }
    
    func bindViewModel() {
        let input = SettingViewModel.Input(
            loadTrigger: Driver.just(()),
            selectedTrigger: tableView.rx.itemSelected.asDriver()
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.dataSource
            .drive(tableView.rx.items) { tableView, index, sectionType in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: SettingCell = tableView.dequeueReusableCell(for: indexPath)
                cell.selectionStyle = .none
                cell.bind(for: sectionType)
                return cell
            }
            .disposed(by: disposeBag)
    }
}
