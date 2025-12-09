import SwiftUI

/// Theme management class.
///
/// Manages the current theme and mode (light/dark/system) for the entire application.
/// Thanks to `@Observable`, changes are automatically reflected in the UI.
///
/// ## Basic usage
/// ```swift
/// @main
/// struct MyApp: App {
///     @State private var themeProvider = ThemeProvider()
///
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///                 .theme(themeProvider)
///         }
///     }
/// }
/// ```
///
/// ## Configuring the mode
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
///
/// ## Switching themes
/// ```swift
/// // テーマを切り替え
/// themeProvider.switchToTheme(id: "ocean")
/// ```
@Observable
    @MainActor
public final class ThemeProvider {
    /// Currently selected theme.
    public var currentTheme: any Theme

    /// Current theme mode (system/light/dark).
    ///
    /// - `.system`: Follows system settings (default)
    /// - `.light`: Always light mode
    /// - `.dark`: Always dark mode
    public var themeMode: ThemeMode

    /// All available themes.
    public private(set) var availableThemes: [any Theme]

    /// Color palette derived from the current theme and mode.
    public var colorPalette: any ColorPalette {
        currentTheme.colorPalette(for: themeMode)
    }

    /// Initializes a new `ThemeProvider`.
    ///
    /// - Parameters:
    ///   - initialTheme: Initial theme (default: `DefaultTheme`).
    ///   - initialMode: Initial mode (default: `.system` – follows system settings).
    ///   - additionalThemes: Additional custom themes to register.
    public init(
        initialTheme: (any Theme)? = nil,
        initialMode: ThemeMode = .system,
        additionalThemes: [any Theme] = []
    ) {
        // Start from built‑in themes.
        var themes = ThemeRegistry.builtInThemes
        
        // If an initial theme is provided, add it to the list.
        if let initialTheme {
            // Avoid duplicates by theme id.
            if !themes.contains(where: { $0.id == initialTheme.id }) {
                themes.append(initialTheme)
            }
        }
        
        // Add additional themes, avoiding duplicates.
        for theme in additionalThemes {
            if !themes.contains(where: { $0.id == theme.id }) {
                themes.append(theme)
            }
        }
        
        self.availableThemes = themes

        // Set initial theme.
        if let initialTheme {
            self.currentTheme = initialTheme
        } else if let defaultTheme = themes.first(where: { $0.id == "default" }) {
            self.currentTheme = defaultTheme
        } else {
            self.currentTheme = themes[0]
        }

        self.themeMode = initialMode
    }

    /// Switches the theme using a theme ID.
    ///
    /// - Parameter id: ID of the theme to switch to.
    ///
    /// ## Example
    /// ```swift
    /// withAnimation {
    ///     themeProvider.switchToTheme(id: "ocean")
    /// }
    /// ```
    public func switchToTheme(id: String) {
        guard let theme = availableThemes.first(where: { $0.id == id }) else {
            print("⚠️ Theme with id '\(id)' not found")
            return
        }
        currentTheme = theme
    }

    /// Applies a theme object directly.
    ///
    /// - Parameter theme: Theme to apply.
    public func applyTheme(_ theme: any Theme) {
        currentTheme = theme
    }

    /// Toggles the mode.
    ///
    /// Cycles through System → Light → Dark → System.
    public func toggleMode() {
        switch themeMode {
        case .system:
            themeMode = .light
        case .light:
            themeMode = .dark
        case .dark:
            themeMode = .system
        }
    }

    /// Registers a custom theme.
    ///
    /// - Parameter theme: Theme to register.
    ///
    /// ## Example
    /// ```swift
    /// struct MyCustomTheme: Theme {
    ///     var id: String { "my-theme" }
    ///     // ... other implementation
    /// }
    ///
    /// themeProvider.registerTheme(MyCustomTheme())
    /// ```
    public func registerTheme(_ theme: any Theme) {
        // Update an existing theme if it already exists, otherwise append.
        if let index = availableThemes.firstIndex(where: { $0.id == theme.id }) {
            availableThemes[index] = theme
        } else {
            availableThemes.append(theme)
        }
    }

    /// Registers multiple custom themes.
    ///
    /// - Parameter themes: Array of themes to register.
    public func registerThemes(_ themes: [any Theme]) {
        themes.forEach { registerTheme($0) }
    }
}
