import SwiftUI
import DesignSystem

// MARK: - App Entry Point

/// Design system catalog app entry point
///
/// ## ThemeProvider Initialization Patterns
///
/// This app demonstrates custom theme usage by initializing
/// `ThemeProvider` with custom themes.
///
/// ### Pattern 1: Set Custom Theme as Initial Theme (Current Implementation)
/// ```swift
/// @State private var themeProvider = ThemeProvider(
///     initialTheme: SimpleRedTheme(),      // Set red theme as initial theme
///     additionalThemes: [SimpleBlueTheme()] // Blue theme also available
/// )
/// ```
///
/// ### Pattern 2: Start with Default Theme, Add Custom Themes
/// ```swift
/// @State private var themeProvider = ThemeProvider(
///     additionalThemes: [SimpleBlueTheme(), SimpleRedTheme()]
/// )
/// // DefaultTheme is initial theme, custom themes also available
/// ```
///
/// ### Pattern 3: Use Only Built-in Themes (Simplest)
/// ```swift
/// @State private var themeProvider = ThemeProvider()
/// // Start with DefaultTheme, select from 7 built-in themes
/// ```
///
/// ## Applying Themes
///
/// To apply ThemeProvider to the view hierarchy, use the `.theme()` modifier:
/// ```swift
/// ContentView()
///     .theme(themeProvider)
/// ```
///
/// ## Reference
/// - Custom theme implementation examples: `Themes/SimpleBlueTheme.swift`, `Themes/SimpleRedTheme.swift`
/// - README.md: Detailed guide for creating custom themes
@main
struct DesignSystemCatalogApp: App {
    @State private var themeProvider = ThemeProvider(
        initialTheme: SimpleRedTheme(),
        additionalThemes: [
            SimpleBlueTheme()
        ]
    )

    var body: some Scene {
        WindowGroup {
            DesignSystemCatalogView()
                .theme(themeProvider)
        }
    }
}
