import SwiftUI
import DesignSystem

// MARK: - Test Custom Theme: Blue Theme

/// Custom theme implementation example: Blue-based theme
///
/// ## Usage
///
/// ### 1. Register with ThemeProvider
/// ```swift
/// @main
/// struct MyApp: App {
///     @State private var themeProvider = ThemeProvider(
///         initialTheme: SimpleBlueTheme(),  // Set as initial theme
///         additionalThemes: [SimpleRedTheme()]  // Additional themes
///     )
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
/// ### 2. Switch Themes
/// ```swift
/// // Switch by theme ID
/// themeProvider.switchToTheme(id: "test-blue")
///
/// // Toggle light/dark mode
/// themeProvider.toggleMode()
/// ```
///
/// ## Custom Theme Creation Points
///
/// 1. **Conform to Theme Protocol**
///    - `id`: Unique identifier (e.g., "myBrand")
///    - `name`: Display name (e.g., "My Brand")
///    - `description`: Description text
///    - `category`: Theme category (.custom, .brandPersonality, etc.)
///    - `previewColors`: Colors for preview (about 3 colors)
///
/// 2. **Light/Dark Mode Support**
///    - Handle `.system`, `.light`, `.dark` cases in `colorPalette(for:)` method
///    - Generally, `.system` and `.light` return the same palette
///
/// 3. **ColorPalette Implementation**
///    - Define all 27 color properties
///    - Set different colors for light and dark modes
///    - In dark mode, adjust to lighter tones to ensure contrast
struct SimpleBlueTheme: Theme {
    var id: String { "test-blue" }
    var name: String { "Test Blue" }
    var description: String { "Simple blue theme for testing" }
    var category: ThemeCategory { .custom }
    var previewColors: [Color] { [.blue, .cyan, .indigo] }

    func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            SimpleBlueColorPalette.light
        case .dark:
            SimpleBlueColorPalette.dark
        }
    }
}

// MARK: - Color Palettes

struct SimpleBlueColorPalette: ColorPalette {
    let primary: Color
    let onPrimary: Color
    let primaryContainer: Color
    let onPrimaryContainer: Color

    let secondary: Color
    let onSecondary: Color
    let secondaryContainer: Color
    let onSecondaryContainer: Color

    let tertiary: Color
    let onTertiary: Color

    let background: Color
    let onBackground: Color
    let surface: Color
    let onSurface: Color
    let surfaceVariant: Color
    let onSurfaceVariant: Color

    let error: Color
    let warning: Color
    let success: Color
    let info: Color

    let outline: Color
    let outlineVariant: Color

    // MARK: - Light Mode Palette

    static let light = SimpleBlueColorPalette(
        primary: .blue,
        onPrimary: .white,
        primaryContainer: Color.blue.opacity(0.1),
        onPrimaryContainer: .blue,

        secondary: .cyan,
        onSecondary: .white,
        secondaryContainer: Color.cyan.opacity(0.1),
        onSecondaryContainer: .cyan,

        tertiary: .indigo,
        onTertiary: .white,

        background: .white,
        onBackground: .black,
        surface: Color(white: 0.98),
        onSurface: Color(white: 0.1),
        surfaceVariant: Color(white: 0.95),
        onSurfaceVariant: Color(white: 0.3),

        error: .red,
        warning: .orange,
        success: .green,
        info: .blue,

        outline: Color(white: 0.8),
        outlineVariant: Color(white: 0.9)
    )

    // MARK: - Dark Mode Palette

    static let dark = SimpleBlueColorPalette(
        primary: Color(red: 0.5, green: 0.7, blue: 1.0), // Lighter blue for dark mode
        onPrimary: Color(white: 0.1),
        primaryContainer: Color.blue.opacity(0.2),
        onPrimaryContainer: Color(red: 0.7, green: 0.85, blue: 1.0),

        secondary: Color(red: 0.4, green: 0.9, blue: 0.9), // Lighter cyan
        onSecondary: Color(white: 0.1),
        secondaryContainer: Color.cyan.opacity(0.2),
        onSecondaryContainer: Color(red: 0.6, green: 0.95, blue: 0.95),

        tertiary: Color(red: 0.6, green: 0.65, blue: 0.95), // Lighter indigo
        onTertiary: Color(white: 0.1),

        background: Color(white: 0.05),
        onBackground: Color(white: 0.95),
        surface: Color(white: 0.12),
        onSurface: Color(white: 0.9),
        surfaceVariant: Color(white: 0.18),
        onSurfaceVariant: Color(white: 0.7),

        error: Color(red: 1.0, green: 0.4, blue: 0.4), // Lighter red
        warning: Color(red: 1.0, green: 0.7, blue: 0.3), // Lighter orange
        success: Color(red: 0.4, green: 0.9, blue: 0.4), // Lighter green
        info: Color(red: 0.5, green: 0.7, blue: 1.0), // Lighter blue

        outline: Color(white: 0.3),
        outlineVariant: Color(white: 0.2)
    )
}
