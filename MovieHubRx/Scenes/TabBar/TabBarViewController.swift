//
//  TabBarViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

final class TabBarViewController: UITabBarController, Bindable {
    var viewModel: TabBarViewModel!
    var disposeBag: DisposeBag! = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func bindViewModel() {
        let input = TabBarViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input, disposeBag: disposeBag)
        
        output.viewControllers
            .drive(onNext: { [weak self] viewControllers in
                self?.setViewControllers(viewControllers, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
