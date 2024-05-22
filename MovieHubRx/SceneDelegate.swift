//
//  SceneDelegate.swift
//  MovieHubRx
//
//  Created by Duy Nguyễn on 13/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var disposeBag = DisposeBag()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        setupTheme()
        binding(window: window)
    }
}

extension SceneDelegate {
    private func binding(window: UIWindow?) {
        guard let window = window else { return }
        let useCase = AppUseCase()
        let navigator = AppNavigator(window: window)
        let viewModel = AppViewModel(useCase: useCase, navigator: navigator)
        
        let changeLanguageTrigger = NotificationCenter.default
            .rx
            .notification(.languageChanged)
            .asDriverOnErrorJustComplete()
            .mapToVoid()
        
        let input = AppViewModel.Input(loadTrigger: Driver.just(()),
                                       changeLanguageTrigger: changeLanguageTrigger)
        _ = viewModel.transform(input, disposeBag: disposeBag)
    }
}

extension SceneDelegate {
    private func setupTheme() {
        guard let rawValue = UserDefaults.standard.value(forKey: UserDefaultsKey.theme.rawValue) as? Int,
              let theme = ThemeType(rawValue: rawValue),
              let window = window else { return }
        window.overrideUserInterfaceStyle = theme.uiUserInterfaceStyle
    }
}
