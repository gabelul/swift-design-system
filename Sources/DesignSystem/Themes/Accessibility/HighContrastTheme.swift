import SwiftUI

/// HighContrast theme – high contrast and accessibility focused.
///
/// High‑contrast color theme oriented toward WCAG AAA compliance.
/// Ideal for low‑vision users and apps that prioritize accessibility.
public struct HighContrastTheme: Theme {
    public init() {}

    public var id: String { "high-contrast" }

    public var name: String { "High Contrast" }

    public var description: String { "WCAG AAA‑oriented, with maximum visibility and accessibility." }

    public var category: ThemeCategory { .accessibility }

    public var previewColors: [Color] {
        [
            Color(hex: "#0050B3"), // Primary (Light mode)
            Color(hex: "#6B0080"), // Secondary (Light mode)
            Color(hex: "#006B56"), // Tertiary (Light mode)
        ]
    }

    public func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            return HighContrastLightPalette()
        case .dark:
            return HighContrastDarkPalette()
        }
    }
}
