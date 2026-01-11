import SwiftUI

/// Card component.
///
/// Generic container for grouping and displaying content.
/// Uses the surface color, corner radius, and elevation to separate content from
/// the surrounding UI.
///
/// ## Example
/// ```swift
/// @Environment(\.spacingScale) var spacing
///
/// Card {
///     VStack(alignment: .leading, spacing: spacing.md) {
///         Text("Title")
///             .typography(.titleMedium)
///         Text("Description")
///             .typography(.bodyMedium)
///     }
/// }
///
/// // Specify elevation level
/// Card(elevation: .level3) {
///     Text("Elevated card")
/// }
/// ```
///
/// ## Use cases
/// - Grouping list items
/// - Information cards
/// - Dashboard widgets
/// - Settings sections
public struct Card<Content: View>: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.radiusScale) private var radiusScale

    private let content: Content
    private let elevation: Elevation
    private let padding: EdgeInsets
    private let cornerRadius: CGFloat?
    private let backgroundColor: Color?

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
