import SwiftUI

/// Elevation level (height/shadow)
///
/// Provides consistent shadow styling to visually express hierarchy and importance of UI elements.
/// Higher levels make elements appear to float closer to the viewer.
///
/// ## Usage
/// ```swift
/// Card {
///     Text("Card content")
/// }
/// .elevation(.level2)  // Standard shadow
///
/// RoundedRectangle(cornerRadius: 12)
///     .fill(Color.white)
///     .frame(width: 200, height: 100)
///     .elevation(.level3)  // Medium shadow
/// ```
///
/// ## Level Guide
/// - **Level 0**: No shadow - embedded elements
/// - **Level 1**: Light shadow - list items, light cards
/// - **Level 2**: Standard shadow - cards, panels (recommended)
/// - **Level 3**: Medium shadow - raised cards
/// - **Level 4**: Strong shadow - modals, popups
/// - **Level 5**: Maximum shadow - drawers, important dialogs
public enum Elevation {
    /// No shadow
    case level0

    /// Light shadow - list items, light cards
    case level1

    /// Standard shadow - cards, panels
    case level2

    /// Medium shadow - raised cards
    case level3

    /// Strong shadow - modals, popups
    case level4

    /// Maximum shadow - drawers, important dialogs
    case level5

    // MARK: - Shadow Properties

    /// Shadow blur radius
    public var radius: CGFloat {
        switch self {
        case .level0: return 0
        case .level1: return 3
        case .level2: return 6
        case .level3: return 8
        case .level4: return 10
        case .level5: return 12
        }
    }

    /// Shadow offset
    public var offset: CGSize {
        switch self {
        case .level0: return .zero
        case .level1: return CGSize(width: 0, height: 1)
        case .level2: return CGSize(width: 0, height: 2)
        case .level3: return CGSize(width: 0, height: 4)
        case .level4: return CGSize(width: 0, height: 6)
        case .level5: return CGSize(width: 0, height: 8)
        }
    }

    /// Shadow opacity (light mode)
    public var opacity: Double {
        switch self {
        case .level0: return 0
        case .level1: return 0.08
        case .level2: return 0.10
        case .level3: return 0.12
        case .level4: return 0.14
        case .level5: return 0.16
        }
    }

    /// Adjusted opacity for dark mode
    /// In dark mode, depth is conveyed through surface brightness differences rather than dark shadows, so shadow opacity is kept subtle.
    public func opacity(for colorScheme: ColorScheme) -> Double {
        colorScheme == .dark ? opacity * 0.55 : opacity
    }

    /// Opacity of the tint layered on top of an elevated surface.
    public func surfaceTintOpacity(for colorScheme: ColorScheme) -> Double {
        switch self {
        case .level0:
            return 0
        case .level1:
            return colorScheme == .dark ? 0.03 : 0.015
        case .level2:
            return colorScheme == .dark ? 0.04 : 0.02
        case .level3:
            return colorScheme == .dark ? 0.05 : 0.025
        case .level4:
            return colorScheme == .dark ? 0.06 : 0.03
        case .level5:
            return colorScheme == .dark ? 0.07 : 0.035
        }
    }
}
