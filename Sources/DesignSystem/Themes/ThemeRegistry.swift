import Foundation

/// Built-in theme registry
///
/// Manages all themes built into the system.
///
/// ## Available Themes
/// - **Standard**: Default theme
/// - **Brand Personality**: Ocean, Forest, Sunset, PurpleHaze, Monochrome
/// - **Accessibility**: HighContrast (WCAG AAA compliant)
///
/// ## Usage Example
/// ```swift
/// // Get all themes
/// let themes = ThemeRegistry.builtInThemes
///
/// // Get by category
/// let brandThemes = ThemeRegistry.themesByCategory[.brandPersonality]
///
/// // Search by ID
/// if let ocean = ThemeRegistry.theme(withID: "ocean") {
///     themeProvider.applyTheme(ocean)
/// }
/// ```
public enum ThemeRegistry {
    /// All built-in themes (7 types)
    public static let builtInThemes: [any Theme] = [
        // Standard
        DefaultTheme(),

        // Brand Personality
        OceanTheme(),
        ForestTheme(),
        SunsetTheme(),
        PurpleHazeTheme(),
        MonochromeTheme(),

        // Accessibility
        HighContrastTheme(),
    ]

    /// Themes grouped by category
    public static var themesByCategory: [ThemeCategory: [any Theme]] {
        Dictionary(grouping: builtInThemes) { $0.category }
    }

    /// Search for a theme by ID
    /// - Parameter id: Theme ID
    /// - Returns: Found theme, or nil
    public static func theme(withID id: String) -> (any Theme)? {
        builtInThemes.first { $0.id == id }
    }
}
