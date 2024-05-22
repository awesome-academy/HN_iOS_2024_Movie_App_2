// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Favorites
    internal static let home = L10n.tr("Localizable", "home")
    internal static let homeWelcome = L10n.tr("Localizable", "home.welcome")
    internal static let homeBio = L10n.tr("Localizable", "home.bio")

  /// Home
    internal static let favorite = L10n.tr("Localizable", "favorite")
  /// Setting
    internal static let setting = L10n.tr("Localizable", "setting.title")
    
    internal static let ok = L10n.tr("Localizable", "common.ok")
    internal static let error = L10n.tr("Localizable", "common.error")
    internal static let theme = L10n.tr("Localizable", "setting.theme")
    
    internal static let themeTitle = L10n.tr("Localizable", "setting.theme.title")
    internal static let darkTheme = L10n.tr("Localizable", "setting.theme.dark")
    internal static let lightTheme = L10n.tr("Localizable", "setting.theme.light")
    internal static let systemTheme = L10n.tr("Localizable", "setting.theme.system")
    internal static let language = L10n.tr("Localizable", "setting.language")
    internal static let languageTitle = L10n.tr("Localizable", "setting.language.title")
    internal static let vnLanguage = L10n.tr("Localizable", "setting.language.vn")
    internal static let enLanguage = L10n.tr("Localizable", "setting.language.en")
    internal static let cancel = L10n.tr("Localizable", "cancel")
    internal static let term = L10n.tr("Localizable", "setting.terms")
    internal static let policy = L10n.tr("Localizable", "setting.policy")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
