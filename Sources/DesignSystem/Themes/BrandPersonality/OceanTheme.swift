import SwiftUI

/// Ocean theme - Professional and calm
///
/// A theme based on deep ocean blue that expresses trust and calm.
/// Ideal for enterprise apps and productivity tools.
public struct OceanTheme: Theme {
    public init() {}

    public var id: String { "ocean" }

    public var name: String { "Ocean" }

    public var description: String { "Deep ocean blue. Professional and calm atmosphere" }

    public var category: ThemeCategory { .brandPersonality }

    public var previewColors: [Color] {
        [
            Color(hex: "#0077BE"), // Primary
            Color(hex: "#00A8CC"), // Secondary
            Color(hex: "#4ECDC4"), // Tertiary
        ]
    }

    public func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            return OceanLightPalette()
        case .dark:
            return OceanDarkPalette()
        }
    }
}
