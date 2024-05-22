//
//  SettingNavigator.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import UIKit
import SafariServices
import RxSwift
import RxCocoa
import Localize_Swift

protocol SettingNavigatorType {
    func showThemeSelectionAlert() -> Observable<UIUserInterfaceStyle>
    func showLanguageSelectionAlert() -> Observable<LanguageType>
    func toTerm()
    func toPolicy()
}

struct SettingNavigator: SettingNavigatorType {
    unowned let navigationController: UINavigationController
    
    func showThemeSelectionAlert() -> Observable<UIUserInterfaceStyle> {
        let subject = PublishSubject<UIUserInterfaceStyle>()
        let alert = UIAlertController(title: nil,
                                      message: L10n.themeTitle.localized(),
                                      preferredStyle: .actionSheet)
        let darkAction = UIAlertAction(title: L10n.darkTheme.localized(),
                                       style: .default) { _ in
            subject.onNext(.dark)
            subject.onCompleted()
        }
        
        let lightAction = UIAlertAction(title: L10n.lightTheme.localized(),
                                        style: .default) { _ in
            subject.onNext(.light)
            subject.onCompleted()
        }
        
        let systemAction = UIAlertAction(title: L10n.systemTheme.localized(),
                                         style: .default) { _ in
            subject.onNext(.unspecified)
            subject.onCompleted()
        }
        
        let cancelAction = UIAlertAction(title: L10n.cancel.localized(),
                                         style: .cancel) { _ in
            subject.onCompleted()
        }
        
        alert.addAction(darkAction)
        alert.addAction(lightAction)
        alert.addAction(systemAction)
        alert.addAction(cancelAction)
        
        navigationController.present(alert, animated: true)
        return subject.asObservable()
    }
    
    func showLanguageSelectionAlert() -> Observable<LanguageType> {
        let subject = PublishSubject<LanguageType>()
        
        let alert = UIAlertController(title: nil,
                                      message: L10n.languageTitle.localized(),
                                      preferredStyle: .actionSheet)
        
        let vnAction = UIAlertAction(title: L10n.vnLanguage.localized(), style: .default) { _ in
            subject.onNext(.vi)
            subject.onCompleted()
        }
        
        let enAction = UIAlertAction(title: L10n.enLanguage.localized(), style: .default) { _ in
            subject.onNext(.en)
            subject.onCompleted()
        }
        
        let cancelAction = UIAlertAction(title: L10n.cancel.localized(), style: .cancel) { _ in
            subject.onCompleted()
        }
        
        alert.addAction(vnAction)
        alert.addAction(enAction)
        alert.addAction(cancelAction)
        
        navigationController.present(alert, animated: true)
        return subject.asObservable()
    }
    
    func toTerm() {
        openSafari(from: navigationController, with: APIUrls.shared.termUrl)
    }
    
    func toPolicy() {
        openSafari(from: navigationController, with: APIUrls.shared.policyUrl)
    }
}
