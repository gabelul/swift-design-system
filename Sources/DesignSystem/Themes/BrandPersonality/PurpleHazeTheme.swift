import SwiftUI

/// PurpleHaze theme - Creative and innovative
///
/// A theme based on vibrant purple and magenta that feels creative and innovative.
/// Ideal for technology, design, and creative tools.
public struct PurpleHazeTheme: Theme {
    public init() {}

    public var id: String { "purple-haze" }

    public var name: String { "Purple Haze" }

    public var description: String { "Vibrant purple. Creative and innovative atmosphere" }

    public var category: ThemeCategory { .brandPersonality }

    public var previewColors: [Color] {
        [
            Color(hex: "#7209B7"), // Primary
            Color(hex: "#B5179E"), // Secondary
            Color(hex: "#F72585"), // Tertiary
        ]
    }

    public func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            return PurpleHazeLightPalette()
        case .dark:
            return PurpleHazeDarkPalette()
        }
    }
}
