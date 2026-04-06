import SwiftUI

/// Forest theme - Natural and grounded
///
/// A theme based on deep forest green that is natural and calming.
/// Ideal for healthcare, outdoor, and sustainability apps.
public struct ForestTheme: Theme {
    public init() {}

    public var id: String { "forest" }

    public var name: String { "Forest" }

    public var description: String { "Deep forest green. Natural and calm atmosphere" }

    public var category: ThemeCategory { .brandPersonality }

    public var previewColors: [Color] {
        [
            Color(hex: "#2D5016"), // Primary
            Color(hex: "#52B788"), // Secondary
            Color(hex: "#74C69D"), // Tertiary
        ]
    }

    public func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            return ForestLightPalette()
        case .dark:
            return ForestDarkPalette()
        }
    }
}
