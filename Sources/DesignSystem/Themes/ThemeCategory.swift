import Foundation

/// Theme category classification
///
/// Groups themes by purpose and use case.
///
/// ## Categories
/// - **standard**: Default basic theme
/// - **brandPersonality**: Diverse themes expressing brand personality (Ocean, Forest, Sunset, etc.)
/// - **accessibility**: WCAG-compliant high contrast theme
public enum ThemeCategory: String, Sendable, CaseIterable, Identifiable {
    /// Standard theme (default)
    case standard = "Standard"

    /// Custom theme (user-defined)
    case custom = "Custom"

    /// Brand personality theme
    case brandPersonality = "Brand Personality"

    /// Accessibility theme
    case accessibility = "Accessibility"

    public var id: String { rawValue }

    /// Category description
    public var description: String {
        switch self {
        case .standard:
            return "Basic light and dark themes"
        case .brandPersonality:
            return "Diverse themes expressing brand personality"
        case .accessibility:
            return "High contrast theme focused on accessibility"
        case .custom:
            return "App-specific custom theme"
        }
    }

    /// Icon name for the category
    public var icon: String {
        switch self {
        case .standard:
            return "circle.lefthalf.filled"
        case .brandPersonality:
            return "paintpalette.fill"
        case .accessibility:
            return "eye.fill"
        case .custom:
            return "wand.and.stars"
        }
    }
}
