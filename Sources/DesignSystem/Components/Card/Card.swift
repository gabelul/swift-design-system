import SwiftUI

/// Card component
///
/// A general-purpose container with elevation (shadow), corner radius, and background color.
/// Used to group content and express visual hierarchy.
///
/// ## Usage
/// ```swift
/// @Environment(\.spacingScale) var spacing
///
/// // Basic usage
/// Card {
///     Text("Default card")
///         .typography(.bodyMedium)
/// }
///
/// // Customize elevation and spacing
/// Card(elevation: .level2) {
///     VStack(alignment: .leading, spacing: spacing.md) {
///         Text("Card Title")
///             .typography(.titleMedium)
///         Text("Card description goes here.")
///             .typography(.bodyMedium)
///     }
/// }
///
/// // Custom corner radius and background color
/// Card(elevation: .level3, cornerRadius: 20, backgroundColor: colors.primaryContainer) {
///     Text("Custom card")
/// }
///
/// // Uniform padding
/// Card(elevation: .level1, allSides: 24) {
///     Text("Uniform padding")
/// }
/// ```
///
/// ## Design Guidelines
/// - **level0–level1**: List items and flat cards
/// - **level2**: Standard cards (recommended)
/// - **level3–level5**: Emphasis and modal-style usage
public struct Card<Content: View>: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.radiusScale) private var radiusScale

    private let content: Content
    private let elevation: Elevation
    private let padding: EdgeInsets
    private let cornerRadius: CGFloat?
    private let backgroundColor: Color?

    /// Creates a card
    ///
    /// - Parameters:
    ///   - elevation: Shadow level (default: `.level1`)
    ///   - padding: Content inset (default: 16pt on all sides)
    ///   - cornerRadius: Corner radius (`nil` uses `RadiusScale.lg`)
    ///   - backgroundColor: Background color (`nil` uses `ColorPalette.surface`)
    ///   - content: Content to display inside the card
    public init(
        elevation: Elevation = .level1,
        padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        cornerRadius: CGFloat? = nil,
        backgroundColor: Color? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.elevation = elevation
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.content = content()
    }

    public var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(padding)
            .background(backgroundColor ?? colorPalette.surface)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius ?? radiusScale.lg))
            .elevation(elevation)
    }
}

public extension Card {
    /// Creates a card with uniform padding
    ///
    /// - Parameters:
    ///   - elevation: Shadow level (default: `.level1`)
    ///   - padding: Uniform padding applied to all sides
    ///   - cornerRadius: Corner radius (`nil` uses `RadiusScale.lg`)
    ///   - backgroundColor: Background color (`nil` uses `ColorPalette.surface`)
    ///   - content: Content to display inside the card
    init(
        elevation: Elevation = .level1,
        allSides padding: CGFloat,
        cornerRadius: CGFloat? = nil,
        backgroundColor: Color? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            elevation: elevation,
            padding: EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding),
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor,
            content: content
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        Card {
            Text("Default Card")
        }
        Card(elevation: .level3, cornerRadius: 20) {
            Text("Custom Corner Radius")
        }
    }
    .padding()
    .theme(ThemeProvider())
}
