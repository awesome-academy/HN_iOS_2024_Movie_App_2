//
//  FavoriteViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

final class FavoriteViewController: UIViewController, Bindable {
    
    var viewModel: FavoriteViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        
    }
    
    func bindViewModel() {
        
    }
}
