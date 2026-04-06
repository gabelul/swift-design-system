import SwiftUI

/// A theme that generates its entire color palette from a single brand color
///
/// Uses HSB color space manipulation to derive primary, secondary, tertiary,
/// surface, and background colors. Semantic state colors (error, warning,
/// success, info) remain fixed for consistent meaning across brands.
///
/// This is the fastest path to a branded app — one color in, full identity out.
///
/// ## Usage
/// ```swift
/// // One line to brand your entire app
/// @State var themeProvider = ThemeProvider(
///     initialTheme: DynamicTheme(brandColor: Color(hex: "#6366F1"))
/// )
///
/// // Change the brand at runtime
/// themeProvider.switchToTheme(
///     DynamicTheme(brandColor: .orange, name: "Sunset Brand")
/// )
/// ```
///
/// ## How Colors Are Derived
/// - **Primary**: The brand color itself
/// - **Secondary**: Hue shifted +30°, saturation ×0.8
/// - **Tertiary**: Hue shifted −30°, saturation ×0.9
/// - **Surfaces**: Desaturated brand tint (light mode: high brightness, dark mode: low brightness)
/// - **Error/Warning/Success/Info**: Fixed semantic colors (these don't shift with brand)
public struct DynamicTheme: Theme, Sendable {
    private let brandColor: Color

    public let id: String
    public let name: String
    public let description: String
    public let category: ThemeCategory = .brandPersonality
    public let previewColors: [Color]

    /// Creates a dynamic theme from a brand color
    ///
    /// - Parameters:
    ///   - brandColor: The single color that defines the brand identity
    ///   - name: Display name for theme pickers (default: "Dynamic")
    ///   - id: Unique identifier (default: "dynamic")
    public init(
        brandColor: Color,
        name: String = "Dynamic",
        id: String = "dynamic"
    ) {
        self.brandColor = brandColor
        self.id = id
        self.name = name
        self.description = "Generated from brand color"
        self.previewColors = [
            brandColor,
            brandColor.adjustingHSB(hueShift: 0.083, saturationMultiplier: 0.8),
            brandColor.adjustingHSB(hueShift: -0.083, saturationMultiplier: 0.9),
        ]
    }

    public func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            DynamicLightPalette(brandColor: brandColor)
        case .dark:
            DynamicDarkPalette(brandColor: brandColor)
        }
    }
}
