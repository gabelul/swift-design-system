import SwiftUI

/// Card component
///
/// A general-purpose container with elevation (shadow), corner radius, and background color.
/// Used to group content and express visual hierarchy.
///
/// ## Usage
///
/// Rendering adapts to the environment's ``SurfaceStyle``:
/// - `.solid` (default): traditional opaque surface + elevation shadow
/// - `.glass` / `.glassProminent`: Liquid Glass. The background shows through,
///   with a gradient border simulating an edge highlight. Elevation is
///   reinterpreted as border brightness and tint intensity rather than shadow
///   depth. Nested cards (depth 1+) automatically downgrade to a subtle tint
///   surface to avoid cloudy overlapping glass.
///
/// ```swift
/// @Environment(\.spacingScale) var spacing
///
/// // Basic usage
/// Card {
///     Text("Default card")
///         .typography(.bodyMedium)
/// }
///
/// // Apply glass rendering to every descendant card (e.g. dynamic trees like A2UI surfaces)
/// A2UISurfaceView(surface)
///     .surfaceStyle(.glass)
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
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.radiusScale) private var radiusScale
    @Environment(\.spacingScale) private var spacingScale
    @Environment(\.surfaceStyle) private var surfaceStyle
    @Environment(\.cardNestingLevel) private var nestingLevel

    private let content: Content
    private let elevation: Elevation
    private let padding: EdgeInsets?
    private let cornerRadius: CGFloat?
    private let backgroundColor: Color?

    /// Creates a card
    ///
    /// - Parameters:
    ///   - elevation: Shadow level (default: `.level1`)
    ///   - padding: Content inset (`nil` uses `SpacingScale.lg` on all sides)
    ///   - cornerRadius: Corner radius (`nil` uses `RadiusScale.lg`)
    ///   - backgroundColor: Background color (`nil` uses an elevation-based surface token)
    ///   - content: Content to display inside the card
    public init(
        elevation: Elevation = .level1,
        padding: EdgeInsets? = nil,
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
        let resolvedPadding = padding ?? EdgeInsets(
            top: spacingScale.lg,
            leading: spacingScale.lg,
            bottom: spacingScale.lg,
            trailing: spacingScale.lg
        )
        // Explicit backgroundColor always renders as solid (caller intent takes priority)
        let renderMode: RenderMode = if backgroundColor != nil || surfaceStyle == .solid {
            .solid
        } else if nestingLevel >= 1 {
            .nestedTint
        } else {
            .glass
        }

        styledCard(renderMode: renderMode) {
            content
                .environment(\.cardNestingLevel, nestingLevel + 1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(resolvedPadding)
        }
    }

    /// Render mode, resolved from surfaceStyle and nesting depth at the top of `body`.
    private enum RenderMode {
        case solid
        case glass
        case nestedTint
    }

    @ViewBuilder
    private func styledCard(renderMode: RenderMode, @ViewBuilder _ padded: () -> some View) -> some View {
        switch renderMode {
        case .solid:
            padded()
                .background {
                    solidBackground
                }
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius ?? radiusScale.lg)
                        .stroke(colorPalette.outlineVariant, lineWidth: 1)
                }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius ?? radiusScale.lg))
                .elevation(elevation)

        case .glass:
            let shape = RoundedRectangle(cornerRadius: cornerRadius ?? radiusScale.lg, style: .continuous)
            padded()
                .background {
                    glassBackground(in: shape)
                }
                .overlay {
                    // Edge highlight: a gradient simulating light sweeping the border
                    // from the top-leading corner. Brightness increases with elevation
                    // (reinterpreting shadow depth).
                    shape.strokeBorder(glassBorderGradient, lineWidth: 1)
                }
                .clipShape(shape)
                .elevation(elevation)

        case .nestedTint:
            // Nested cards: overlapping glass looks cloudy, so downgrade to a subtle
            // tint surface that only handles proximity grouping (no shadow, hairline border)
            let shape = RoundedRectangle(cornerRadius: cornerRadius ?? radiusScale.lg, style: .continuous)
            padded()
                .background {
                    shape.fill(colorPalette.onSurface.opacity(colorScheme == .dark ? 0.06 : 0.04))
                }
                .overlay {
                    shape.strokeBorder(colorPalette.outlineVariant.opacity(0.6), lineWidth: 1)
                }
                .clipShape(shape)
        }
    }

    // MARK: - Solid

    @ViewBuilder
    private var solidBackground: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius ?? radiusScale.lg)

        if let backgroundColor {
            shape.fill(backgroundColor)
        } else {
            let baseColor = elevatedSurfaceColor
            shape
                .fill(baseColor)
                .overlay {
                    shape.fill(colorPalette.primary.opacity(elevation.surfaceTintOpacity(for: colorScheme)))
                }
        }
    }

    private var elevatedSurfaceColor: Color {
        switch elevation {
        case .level0:
            colorPalette.surface
        case .level1, .level2, .level3:
            colorPalette.elevatedSurface
        case .level4, .level5:
            colorPalette.elevatedSurfaceHigh
        }
    }

    // MARK: - Glass

    @ViewBuilder
    private func glassBackground(in shape: RoundedRectangle) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            Color.clear.glassEffect(glassMaterial, in: shape)
        } else {
            shape
                .fill(.ultraThinMaterial)
                .overlay {
                    if surfaceStyle == .glassProminent {
                        shape.fill(colorPalette.primary.opacity(0.06))
                    }
                }
        }
    }

    @available(iOS 26.0, macOS 26.0, *)
    private var glassMaterial: Glass {
        var glass: Glass = .regular
        if surfaceStyle == .glassProminent {
            glass = glass.tint(colorPalette.primary.opacity(0.18))
        }
        return glass
    }

    /// Gradient border that lights up the glass edge.
    /// Brightness increases progressively from elevation level0 to level5.
    private var glassBorderGradient: LinearGradient {
        let highlight = glassBorderHighlightOpacity
        return LinearGradient(
            colors: [
                .white.opacity(highlight),
                .white.opacity(highlight * 0.12),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var glassBorderHighlightOpacity: Double {
        let base: Double = switch elevation {
        case .level0: 0.22
        case .level1: 0.32
        case .level2: 0.40
        case .level3: 0.48
        case .level4: 0.56
        case .level5: 0.64
        }
        let prominentBoost: Double = surfaceStyle == .glassProminent ? 0.12 : 0
        // In light mode the white border recedes, so boost it slightly
        let schemeBoost: Double = colorScheme == .light ? 0.08 : 0
        return min(base + prominentBoost + schemeBoost, 0.85)
    }
}

public extension Card {
    /// Creates a card with uniform padding
    ///
    /// - Parameters:
    ///   - elevation: Shadow level (default: `.level1`)
    ///   - padding: Uniform padding applied to all sides
    ///   - cornerRadius: Corner radius (`nil` uses `RadiusScale.lg`)
    ///   - backgroundColor: Background color (`nil` uses an elevation-based surface token)
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

#Preview("Solid") {
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

#Preview("Glass") {
    ZStack {
        LinearGradient(
            colors: [.purple, .blue, .cyan],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        VStack(spacing: 16) {
            Card(elevation: .level2) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Glass Card")
                    // Nested cards automatically downgrade to a tint surface
                    Card(elevation: .level1) {
                        Text("Nested Card (auto-downgraded)")
                    }
                }
            }
            Card(elevation: .level3, cornerRadius: 24) {
                Text("Prominent Glass")
            }
            .surfaceStyle(.glassProminent)
        }
        .padding()
        .surfaceStyle(.glass)
    }
    .theme(ThemeProvider())
}
