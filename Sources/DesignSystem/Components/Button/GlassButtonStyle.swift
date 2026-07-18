import SwiftUI

/// A neutral (uncolored) Liquid Glass button style.
///
/// For secondary actions that pair with `.primaryGlass`. Use it when you want
/// to keep the background translucent while composing a group of actions in
/// the same glass language. The standard secondary button for glass surfaces
/// (`surfaceStyle(.glass)`).
public struct GlassButtonStyle: ButtonStyle {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.buttonSize) private var buttonSize
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.motion) private var motion

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .typography(buttonSize.typography)
            .foregroundStyle(colorPalette.onSurface)
            .padding(.horizontal, buttonSize.horizontalPadding)
            .frame(minHeight: buttonSize.height)
            // macOS sizes to content width (per HIG, full-width fill is a watchOS idiom; macOS fits width to content).
            #if os(iOS)
            .frame(maxWidth: .infinity)
            #endif
            .background {
                backgroundShape
            }
            .elevation(.level2)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.6)
            .animate(motion.tap, value: configuration.isPressed)
    }

    @ViewBuilder
    private var backgroundShape: some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            Capsule()
                .fill(.clear)
                .glassEffect(.regular.interactive(true), in: Capsule())
        } else {
            Capsule()
                .fill(.ultraThinMaterial)
                .overlay {
                    Capsule().strokeBorder(colorPalette.outlineVariant, lineWidth: 1)
                }
        }
    }
}

public extension ButtonStyle where Self == GlassButtonStyle {
    /// A neutral (uncolored) Liquid Glass button style.
    static var glass: GlassButtonStyle {
        GlassButtonStyle()
    }
}
