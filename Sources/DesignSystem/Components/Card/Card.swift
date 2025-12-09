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
    @Environment(\.spacingScale) private var spacing

    private let content: Content
    private let elevation: Elevation
    private let padding: EdgeInsets

    public init(
        elevation: Elevation = .level1,
        padding: EdgeInsets? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.elevation = elevation
        // Default padding is spacing.lg, but @Environment is not available in init,
        // so we use a fixed value here and align with spacing.lg in practice.
        self.padding = padding ?? EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        self.content = content()
    }

    public var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(padding)
            .background(colorPalette.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .elevation(elevation)
    }
}

// MARK: - Convenience Initializers

public extension Card {
    /// Initializes a card with custom edge insets.
    /// Prefer using spacing tokens for consistency.
    init(
        elevation: Elevation = .level1,
        top: CGFloat,
        leading: CGFloat,
        bottom: CGFloat,
        trailing: CGFloat,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            elevation: elevation,
            padding: EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing),
            content: content
        )
    }

    /// Initializes a card with the same padding on all sides.
    /// Prefer using spacing tokens for consistency.
    init(
        elevation: Elevation = .level1,
        allSides padding: CGFloat,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            elevation: elevation,
            padding: EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding),
            content: content
        )
    }
}

struct CardPreview: View {
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        VStack(spacing: spacing.lg) {
            Card {
                Text("Default Card (spacing.lg padding)")
            }

            Card(elevation: .level3) {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("Elevated Card")
                        .typography(.titleMedium)
                    Text("Level 3 elevation")
                        .typography(.bodySmall)
                }
            }

            Card(allSides: spacing.xl) {
                Text("Custom Padding (spacing.xl)")
            }
        }
        .padding()
    }
}

#Preview {
    CardPreview()
        .theme(ThemeProvider())
}
