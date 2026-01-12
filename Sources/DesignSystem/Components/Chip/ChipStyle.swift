import SwiftUI

/// Chip Component Style Protocol
///
/// The ChipStyle protocol defines visual variations for Chips.
/// You can create reusable styles similar to SwiftUI's ButtonStyle pattern.
///
/// ## Creating Custom Styles
/// ```swift
/// struct CustomChipStyle: ChipStyle {
///     func makeBody(configuration: ChipStyleConfiguration) -> some View {
///         HStack(spacing: 4) {
///             if let icon = configuration.icon {
///                 icon
///             }
///             configuration.label
///             if let onDelete = configuration.onDelete {
///                 Button(action: onDelete) {
///                     Image(systemName: "xmark.circle.fill")
///                 }
///             }
///         }
///         .padding(.horizontal, 12)
///         .padding(.vertical, 6)
///         .background(Color.blue.opacity(0.2))
///         .cornerRadius(16)
///     }
/// }
/// ```
public protocol ChipStyle: Sendable {
    /// The View type produced by the style
    associatedtype Body: View

    /// Builds the appearance of the Chip
    /// - Parameter configuration: Chip configuration information
    /// - Returns: View with the style applied
    @MainActor
    func makeBody(configuration: ChipStyleConfiguration) -> Body
}

/// Configuration information passed to ChipStyle
///
/// Contains information such as the Chip's label, icon, delete handler, selection state, etc.
public struct ChipStyleConfiguration {
    /// The Chip's label text
    public let label: AnyView

    /// Icon to display at the beginning (optional)
    public let icon: AnyView?

    /// Delete button handler (optional)
    /// When set, operates as a deletable Input Chip
    public let onDelete: (() -> Void)?

    /// Selection state (for filter chips, etc.)
    public let isSelected: Bool

    /// Pressed state (for tap feedback)
    public let isPressed: Bool

    /// Current Chip size
    public let size: ChipSize

    /// Color palette
    public let colorPalette: any ColorPalette

    /// Spacing scale
    public let spacingScale: any SpacingScale

    /// Corner radius scale
    public let radiusScale: any RadiusScale

    /// Motion timing
    public let motion: any Motion
}

/// EnvironmentKey for ChipStyle
private struct ChipStyleKey: EnvironmentKey {
    static let defaultValue: AnyChipStyle = AnyChipStyle(FilledChipStyle())
}

public extension EnvironmentValues {
    /// ChipStyle retrieved from the environment
    var chipStyle: AnyChipStyle {
        get { self[ChipStyleKey.self] }
        set { self[ChipStyleKey.self] = newValue }
    }
}

/// Type-erased ChipStyle
public struct AnyChipStyle: ChipStyle {
    private let _makeBody: @MainActor @Sendable (ChipStyleConfiguration) -> AnyView

    init<S: ChipStyle>(_ style: S) where S: Sendable {
        _makeBody = { @MainActor @Sendable configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    @MainActor
    public func makeBody(configuration: ChipStyleConfiguration) -> some View {
        _makeBody(configuration)
    }
}
