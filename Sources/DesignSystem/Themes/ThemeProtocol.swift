import SwiftUI

/// Protocol that defines a design system theme
///
/// A theme provides metadata such as name, description, and category,
/// as well as color palettes for light and dark modes.
///
/// ## Usage Example
/// ```swift
/// struct CustomTheme: Theme {
///     let id = "custom"
///     let name = "Custom"
///     let description = "Custom color theme"
///     let category: ThemeCategory = .brandPersonality
///     let previewColors = [.blue, .cyan, .teal]
///
///     func colorPalette(for mode: ThemeMode) -> any ColorPalette {
///         switch mode {
///         case .light: return CustomLightPalette()
///         case .dark: return CustomDarkPalette()
///         }
///     }
/// }
/// ```
public protocol Theme: Sendable, Identifiable, Equatable {
    /// Unique identifier for the theme
    var id: String { get }

    /// Display name of the theme
    var name: String { get }

    /// Description of the theme
    var description: String { get }

    /// Category of the theme
    var category: ThemeCategory { get }

    /// Representative colors for preview (3-5 colors)
    var previewColors: [Color] { get }

    /// Returns the color palette corresponding to the specified mode
    /// - Parameter mode: Light mode or dark mode
    /// - Returns: Corresponding color palette
    func colorPalette(for mode: ThemeMode) -> any ColorPalette
}

// MARK: - Equatable Default Implementation

public extension Theme {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
