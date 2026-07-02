import SwiftUI

/// Button size variants
///
/// Uniformly manages button height, padding, and font size.
///
/// ## Usage Examples
/// ```swift
/// Button("Login") {
///     login()
/// }
/// .buttonStyle(.primary)
/// .buttonSize(.large)  // 56pt height (default)
///
/// Button("Cancel") {
///     cancel()
/// }
/// .buttonStyle(.secondary)
/// .buttonSize(.small)  // 40pt height
/// ```
///
/// ## Size List
/// - **Large**: 56pt height - Primary actions (default)
/// - **Medium**: 48pt height - Standard buttons
/// - **Small**: 40pt height - Compact layouts
public enum ButtonSize: Sendable {
    /// Large size (56pt) - Primary actions
    case large

    /// Medium size (48pt) - Standard buttons
    case medium

    /// Small size (40pt) - Compact layouts
    case small

    /// Button height
    ///
    /// macOS assumes pointer-based interaction, so instead of the large
    /// touch-oriented heights (56/48/40), it scales down to dimensions closer
    /// to standard controls (per HIG, 44pt is the minimum hit region, not the
    /// button's own size). iOS dimensions remain unchanged.
    var height: CGFloat {
        #if os(macOS)
        switch self {
        case .large: return 32
        case .medium: return 28
        case .small: return 22
        }
        #else
        switch self {
        case .large: return 56
        case .medium: return 48
        case .small: return 40
        }
        #endif
    }

    /// Horizontal padding
    var horizontalPadding: CGFloat {
        #if os(macOS)
        switch self {
        case .large: return 16
        case .medium: return 12
        case .small: return 10
        }
        #else
        switch self {
        case .large: return 24
        case .medium: return 20
        case .small: return 16
        }
        #endif
    }

    /// Typography token
    var typography: Typography {
        switch self {
        case .large: return .labelLarge
        case .medium: return .labelMedium
        case .small: return .labelSmall
        }
    }
}

// MARK: - Environment Key

private struct ButtonSizeKey: EnvironmentKey {
    static let defaultValue: ButtonSize = .large
}

public extension EnvironmentValues {
    var buttonSize: ButtonSize {
        get { self[ButtonSizeKey.self] }
        set { self[ButtonSizeKey.self] = newValue }
    }
}

public extension View {
    /// Set button size
    ///
    /// Changes button height, padding, and text size all at once.
    ///
    /// - Parameter size: Button size (`.large`, `.medium`, `.small`)
    ///
    /// ## Usage Examples
    /// ```swift
    /// Button("Login") { }
    ///     .buttonStyle(.primary)
    ///     .buttonSize(.medium)
    ///
    /// Button("Small Button") { }
    ///     .buttonStyle(.secondary)
    ///     .buttonSize(.small)
    /// ```
    func buttonSize(_ size: ButtonSize) -> some View {
        environment(\.buttonSize, size)
    }
}
