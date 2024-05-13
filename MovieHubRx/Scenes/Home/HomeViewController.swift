//
//  HomeViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController, Bindable {

    var viewModel: HomeViewModel!
    var disposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
    }
    
    func bindViewModel() {
        
    }
}
