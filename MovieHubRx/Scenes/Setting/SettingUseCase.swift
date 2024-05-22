//
//  SettingUseCase.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import Foundation
import RxSwift
import RxCocoa
import Localize_Swift

protocol SettingUseCaseType {
    func setTheme(_ theme: ThemeType) -> Observable<Void>
    func setLanguage(_ language: LanguageType) -> Observable<Void>
}

struct SettingUseCase: SettingUseCaseType {

    func setTheme(_ theme: ThemeType) -> Observable<Void> {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = theme.uiUserInterfaceStyle
            UserDefaults.standard.set(theme.rawValue, forKey: UserDefaultsKey.theme.rawValue)
        }
        return Observable.just(())
    }
    
    func setLanguage(_ language: LanguageType) -> Observable<Void> {
        Localize.setCurrentLanguage(language.rawValue)
        return Observable.just(())
    }
}
