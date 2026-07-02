import SwiftUI

public extension View {
    /// Lays down a Liquid Glass surface background. Use it for surfaces like
    /// cards, rows, and composers.
    ///
    /// Falls back to ultraThinMaterial + an outline below iOS 26.
    ///
    /// Note: for uses that repeat multiple instances inside a `ScrollView`
    /// (carousels, chip rows, marquees, etc.), use
    /// ``frostedSurface(cornerRadius:tint:)`` instead. `glassEffect` produces
    /// a visual artifact in that context — a "band" the height of the row
    /// spanning the full width of the scroll area.
    /// - Parameters:
    ///   - cornerRadius: Corner radius.
    ///   - tint: Tint color layered over the glass.
    ///   - interactive: Whether the glass should react to touch.
    func glassSurface(cornerRadius: CGFloat = 16, tint: Color? = nil, interactive: Bool = false) -> some View {
        modifier(GlassSurfaceModifier(cornerRadius: cornerRadius, tint: tint, interactive: interactive))
    }

    /// A material-based frosted surface background for surfaces that repeat
    /// inside a scroll area.
    ///
    /// `glassEffect` produces a "band" the height of the row spanning the
    /// full width of the scroll area when repeated inside a `ScrollView`, so
    /// flowing elements like carousels, chip rows, and marquees should use
    /// this instead. Its look is aligned with the glass surfaces via a
    /// gradient hairline edge highlight.
    /// - Parameters:
    ///   - cornerRadius: Corner radius.
    ///   - tint: Tint color layered over the material.
    func frostedSurface(cornerRadius: CGFloat = 16, tint: Color? = nil) -> some View {
        modifier(FrostedSurfaceModifier(cornerRadius: cornerRadius, tint: tint))
    }
}

struct FrostedSurfaceModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    let cornerRadius: CGFloat
    let tint: Color?

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        content
            .background {
                shape.fill(.ultraThinMaterial)
                    .overlay {
                        if let tint { shape.fill(tint.opacity(0.08)) }
                    }
            }
            .overlay {
                shape.strokeBorder(
                    LinearGradient(
                        colors: [
                            .white.opacity(colorScheme == .light ? 0.45 : 0.35),
                            .white.opacity(0.05),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
            }
    }
}

struct GlassSurfaceModifier: ViewModifier {
    @Environment(\.colorPalette) private var colorPalette
    let cornerRadius: CGFloat
    let tint: Color?
    let interactive: Bool

    func body(content: Content) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            content.glassEffect(glass, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        } else {
            content
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(colorPalette.outlineVariant, lineWidth: 1)
                }
        }
    }

    @available(iOS 26.0, macOS 26.0, *)
    private var glass: Glass {
        var glass: Glass = .regular
        if let tint { glass = glass.tint(tint) }
        if interactive { glass = glass.interactive() }
        return glass
    }
}
