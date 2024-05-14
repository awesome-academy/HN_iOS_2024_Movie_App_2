//
//  MovieDetailViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 14/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieDetailViewController: UIViewController, Bindable {
    
    var viewModel: MovieDetailViewModel!
    var disposeBag: DisposeBag! = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        
    }
    
    func bindViewModel() {
        
    }
}
