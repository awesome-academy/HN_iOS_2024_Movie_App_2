//
//  SettingViewModel.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct SettingViewModel {
    let useCase: SettingUseCaseType
    let navigator: SettingNavigatorType
}

extension SettingViewModel: ViewModelType {
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectedTrigger: Driver<IndexPath>
    }
    
    struct  Output {
        let dataSource: Driver<[SettingSectionType]>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let dataSource = input.loadTrigger
            .map { SettingSectionType.allCases }
            .asDriver(onErrorJustReturn: [])
        
        let selectedSection = input.selectedTrigger
            .flatMapLatest { indexPath in
                dataSource.map { $0[indexPath.row] }
            }
        
        selectedSection
            .filter { $0 == .theme }
            .flatMapLatest { _ in
                self.navigator.showThemeSelectionAlert()
                    .asDriver(onErrorJustReturn: .unspecified)
            }
            .compactMap { theme in
                ThemeType(rawValue: theme.rawValue)
            }
            .flatMap { selectedTheme in
                self.useCase.setTheme(selectedTheme)
                    .asDriver(onErrorJustReturn: ())
            }
            .drive()
            .disposed(by: disposeBag)
        
        selectedSection
            .filter { $0 == .language }
            .flatMapLatest { _ in
                self.navigator.showLanguageSelectionAlert()
                    .asDriver(onErrorJustReturn: .en)
            }
            .flatMap { language in
                self.useCase.setLanguage(language)
                    .asDriver(onErrorJustReturn: ())
            }
            .drive(onNext: {
                NotificationCenter.default.post(name: .languageChanged, object: nil)
            })
            .disposed(by: disposeBag)
        
        selectedSection
            .filter { $0 == .term }
            .drive(onNext: { _ in
                self.navigator.toTerm()
            })
            .disposed(by: disposeBag)
        
        selectedSection
            .filter { $0 == .policy }
            .drive(onNext: { _ in
                self.navigator.toPolicy()
            })
            .disposed(by: disposeBag)
        
        return Output(dataSource: dataSource)
    }
}
