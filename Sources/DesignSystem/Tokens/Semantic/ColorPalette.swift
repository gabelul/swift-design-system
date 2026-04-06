import SwiftUI

/// Color palette protocol
///
/// Provides different color implementations per theme, ensuring consistent color usage across the app.
/// Supports Light/Dark themes, custom brand colors, and more.
///
/// ## Usage
/// ```swift
/// @Environment(\.colorPalette) var colors
///
/// VStack {
///     Text("Heading")
///         .foregroundColor(colors.primary)
///     Text("Body text")
///         .foregroundColor(colors.onSurface)
/// }
/// .background(colors.surface)
/// ```
///
/// ## Creating a Custom Theme
/// ```swift
/// struct MyBrandPalette: ColorPalette {
///     var primary: Color { Color(hex: "#007AFF") }
///     var background: Color { .white }
///     var surface: Color { Color(hex: "#F2F2F7") }
///     // ... implement other required properties
/// }
///
/// // Use the palette in a Theme
/// struct MyBrandTheme: Theme {
///     var id: String { "myBrand" }
///     var name: String { "My Brand" }
///     var description: String { "Brand color theme" }
///     var category: ThemeCategory { .brandPersonality }
///     var previewColors: [Color] { [Color(hex: "#007AFF")] }
///
///     func colorPalette(for mode: ThemeMode) -> any ColorPalette {
///         switch mode {
///         case .system, .light: MyBrandPalette()
///         case .dark: MyBrandDarkPalette()
///         }
///     }
/// }
///
/// // Register with ThemeProvider
/// ThemeProvider(initialTheme: MyBrandTheme())
/// ```
public protocol ColorPalette: Sendable {
    // MARK: - Primary Colors

    /// Used for main actions and brand elements
    var primary: Color { get }

    /// Text/icon color on Primary backgrounds
    var onPrimary: Color { get }

    /// Lighter Primary variant (for container backgrounds)
    var primaryContainer: Color { get }

    /// Text color on PrimaryContainer backgrounds
    var onPrimaryContainer: Color { get }

    // MARK: - Secondary Colors

    /// Secondary accent color
    var secondary: Color { get }

    /// Text/icon color on Secondary backgrounds
    var onSecondary: Color { get }

    /// Lighter Secondary variant (for container backgrounds)
    var secondaryContainer: Color { get }

    /// Text color on SecondaryContainer backgrounds
    var onSecondaryContainer: Color { get }

    // MARK: - Tertiary Colors

    /// Third accent color (for additional emphasis)
    var tertiary: Color { get }

    /// Text/icon color on Tertiary backgrounds
    var onTertiary: Color { get }

    // MARK: - Background & Surface

    /// App-wide background color
    var background: Color { get }

    /// Text color on Background
    var onBackground: Color { get }

    /// Surface color for cards, sheets, dialogs, etc.
    var surface: Color { get }

    /// Text color on Surface
    var onSurface: Color { get }

    /// Alternative surface color (for subtle differentiation)
    var surfaceVariant: Color { get }

    /// Text color on SurfaceVariant
    var onSurfaceVariant: Color { get }

    // MARK: - Semantic State Colors

    /// Used for error states
    var error: Color { get }

    /// Text color on Error backgrounds
    var onError: Color { get }

    /// Lighter error variant (for container backgrounds)
    var errorContainer: Color { get }

    /// Text color on ErrorContainer backgrounds
    var onErrorContainer: Color { get }

    /// Used for warning states
    var warning: Color { get }

    /// Text color on Warning backgrounds
    var onWarning: Color { get }

    /// Used for success states
    var success: Color { get }

    /// Text color on Success backgrounds
    var onSuccess: Color { get }

    /// Used for informational displays
    var info: Color { get }

    /// Text color on Info backgrounds
    var onInfo: Color { get }

    // MARK: - Outline & Border

    /// Used for borders, dividers, and outlines
    var outline: Color { get }

    /// Lighter outline variant
    var outlineVariant: Color { get }
}

// MARK: - Default Implementations

public extension ColorPalette {
    // Default implementations for derived colors
    var primaryContainer: Color { primary.opacity(0.12) }
    var onPrimaryContainer: Color { primary }
    var secondaryContainer: Color { secondary.opacity(0.12) }
    var onSecondaryContainer: Color { secondary }

    var errorContainer: Color { error.opacity(0.12) }
    var onErrorContainer: Color { error }

    // Default on~ colors
    var onPrimary: Color { .white }
    var onSecondary: Color { .white }
    var onTertiary: Color { .white }
    var onError: Color { .white }
    var onWarning: Color { .black }
    var onSuccess: Color { .white }
    var onInfo: Color { .white }

    var outlineVariant: Color { outline.opacity(0.5) }
}
