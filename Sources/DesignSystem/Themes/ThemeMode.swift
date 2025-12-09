import Foundation

/// Theme light/dark mode.
///
/// Controls which color palette is used for a theme.
///
/// ## Modes
/// - **system**: Follows the system appearance (default)
/// - **light**: Always light mode
/// - **dark**: Always dark mode
///
/// ## Example
/// ```swift
/// // Follow system (default)
/// themeProvider.themeMode = .system
///
/// // Force light mode
/// themeProvider.themeMode = .light
///
/// // Force dark mode
/// themeProvider.themeMode = .dark
/// ```
public enum ThemeMode: String, Sendable, CaseIterable {
    /// Follows the system appearance.
    case system = "System"

    /// Always light mode.
    case light = "Light"

    /// Always dark mode.
    case dark = "Dark"
}
