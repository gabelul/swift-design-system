import SwiftUI
import DesignSystem

// MARK: - Test Custom Theme: Red Theme

/// Custom theme implementation example: Red-based theme
///
/// This theme is a sample implementation paired with `SimpleBlueTheme`.
/// By defining different colors using the same pattern, you can easily create multiple custom themes.
///
/// ## Usage
///
/// ### Registering with ThemeProvider
/// ```swift
/// @State private var themeProvider = ThemeProvider(
///     initialTheme: SimpleRedTheme(),  // Set red theme as initial theme
///     additionalThemes: [SimpleBlueTheme()]  // Blue theme also available
/// )
/// ```
///
/// ### Registering Multiple Custom Themes
/// ```swift
/// @State private var themeProvider = ThemeProvider(
///     additionalThemes: [
///         SimpleBlueTheme(),
///         SimpleRedTheme(),
///         MyBrandTheme()  // Additional custom theme
///     ]
/// )
/// ```
///
/// ## Reference
/// - SimpleBlueTheme: More detailed documentation and implementation examples
struct SimpleRedTheme: Theme {
    var id: String { "test-red" }
    var name: String { "Test Red" }
    var description: String { "Simple red theme for testing" }
    var category: ThemeCategory { .custom }
    var previewColors: [Color] { [.red, .pink, .orange] }

    func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            SimpleRedColorPalette.light
        case .dark:
            SimpleRedColorPalette.dark
        }
    }
}

// MARK: - Color Palettes

struct SimpleRedColorPalette: ColorPalette {
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

    static let light = SimpleRedColorPalette(
        primary: .red,
        onPrimary: .white,
        primaryContainer: Color.red.opacity(0.1),
        onPrimaryContainer: .red,

        secondary: .pink,
        onSecondary: .white,
        secondaryContainer: Color.pink.opacity(0.1),
        onSecondaryContainer: .pink,

        tertiary: .orange,
        onTertiary: .white,

        background: .white,
        onBackground: .black,
        surface: Color(white: 0.98),
        onSurface: Color(white: 0.1),
        surfaceVariant: Color(white: 0.95),
        onSurfaceVariant: Color(white: 0.3),

        error: Color(red: 0.8, green: 0.2, blue: 0.2),
        warning: .orange,
        success: .green,
        info: .blue,

        outline: Color(white: 0.8),
        outlineVariant: Color(white: 0.9)
    )

    // MARK: - Dark Mode Palette

    static let dark = SimpleRedColorPalette(
        primary: Color(red: 1.0, green: 0.5, blue: 0.5), // Lighter red for dark mode
        onPrimary: Color(white: 0.1),
        primaryContainer: Color.red.opacity(0.2),
        onPrimaryContainer: Color(red: 1.0, green: 0.7, blue: 0.7),

        secondary: Color(red: 1.0, green: 0.6, blue: 0.8), // Lighter pink
        onSecondary: Color(white: 0.1),
        secondaryContainer: Color.pink.opacity(0.2),
        onSecondaryContainer: Color(red: 1.0, green: 0.8, blue: 0.9),

        tertiary: Color(red: 1.0, green: 0.7, blue: 0.4), // Lighter orange
        onTertiary: Color(white: 0.1),

        background: Color(white: 0.05),
        onBackground: Color(white: 0.95),
        surface: Color(white: 0.12),
        onSurface: Color(white: 0.9),
        surfaceVariant: Color(white: 0.18),
        onSurfaceVariant: Color(white: 0.7),

        error: Color(red: 1.0, green: 0.3, blue: 0.3), // Lighter error red
        warning: Color(red: 1.0, green: 0.7, blue: 0.3), // Lighter orange
        success: Color(red: 0.4, green: 0.9, blue: 0.4), // Lighter green
        info: Color(red: 0.5, green: 0.7, blue: 1.0), // Lighter blue

        outline: Color(white: 0.3),
        outlineVariant: Color(white: 0.2)
    )
}
