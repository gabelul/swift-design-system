import SwiftUI

/// Chip Component Size Variants
///
/// Tokens that define the size of Chips. You can select the appropriate size
/// for your use case, such as status displays, category tags, and filters.
///
/// ## Usage Example
/// ```swift
/// Chip("Active", systemImage: "circle.fill")
///     .chipSize(.medium)  // Default
///
/// Chip("New", systemImage: "bell.fill")
///     .chipSize(.small)   // Compact display
/// ```
///
/// ## Size Guidelines
/// - **Small**: For dense layouts, auxiliary information (24pt)
/// - **Medium**: For standard use, prioritizing readability (32pt)
public enum ChipSize: Sendable {
    /// Small size (24pt) - For compact layouts
    case small

    /// Medium size (32pt) - Standard chips
    case medium

    /// Chip height
    var height: CGFloat {
        switch self {
        case .small: return 24
        case .medium: return 32
        }
    }

    /// Horizontal padding
    var horizontalPadding: CGFloat {
        switch self {
        case .small: return 6
        case .medium: return 8
        }
    }

    /// Vertical padding
    var verticalPadding: CGFloat {
        switch self {
        case .small: return 2
        case .medium: return 4
        }
    }

    /// Icon size
    var iconSize: CGFloat {
        switch self {
        case .small: return 14
        case .medium: return 18
        }
    }

    /// Typography token
    var typography: Typography {
        switch self {
        case .small: return .labelSmall
        case .medium: return .labelMedium
        }
    }
}

/// EnvironmentKey for ChipSize
private struct ChipSizeKey: EnvironmentKey {
    static let defaultValue: ChipSize = .medium
}

public extension EnvironmentValues {
    /// ChipSize retrieved from the environment
    var chipSize: ChipSize {
        get { self[ChipSizeKey.self] }
        set { self[ChipSizeKey.self] = newValue }
    }
}
