//
//  SettingViewController.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingViewController: UIViewController, Bindable {
    
    var viewModel: SettingViewModel!
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
