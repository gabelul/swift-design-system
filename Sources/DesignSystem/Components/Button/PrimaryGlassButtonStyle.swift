import SwiftUI

/// A Liquid Glass button style tinted with the primary color.
///
/// Use it for floating actions or actions pinned to the bottom of the
/// screen — anywhere you want a translucent background while still reading
/// as part of the same primary-colored action group.
public struct PrimaryGlassButtonStyle: ButtonStyle {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.buttonSize) private var buttonSize
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.motion) private var motion

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .typography(buttonSize.typography)
            .foregroundStyle(colorPalette.primary)
            .padding(.horizontal, buttonSize.horizontalPadding)
            .frame(minHeight: buttonSize.height)
            // macOS sizes to content width (per HIG, full-width fill is a watchOS idiom; macOS fits width to content).
            #if os(iOS)
            .frame(maxWidth: .infinity)
            #endif
            .background {
                backgroundShape
            }
            .elevation(.level3)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.6)
            .animate(motion.tap, value: configuration.isPressed)
            // The whole button keeps the height it measured, background included.
            // Putting this on the label alone is not enough: the squeeze happens to
            // the button, so the background shape stays short while the label draws
            // its full height centred inside it — which is how a multi-line title
            // ends up bleeding above and below its own capsule at accessibility
            // text sizes, on top of whatever sits below.
            .fixedSize(horizontal: false, vertical: true)
    }

    /// The background outline. A rounded rectangle capped at the single-line
    /// radius rather than a capsule: a capsule's radius follows half the rendered
    /// height, so once a button wraps to several lines the corners curve inward
    /// across the first and last line and clip their leading characters. Short
    /// buttons are unchanged — at one line this is exactly a capsule.
    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: buttonSize.cornerRadius, style: .continuous)
    }

    @ViewBuilder
    private var backgroundShape: some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            shape
                .fill(colorPalette.primary.opacity(0.05))
                .glassEffect(.regular.tint(colorPalette.primary.opacity(0.18)).interactive(true), in: shape)
        } else {
            shape
                .fill(colorPalette.primary.opacity(0.06))
                .background(.ultraThinMaterial, in: shape)
        }
    }
}

public extension ButtonStyle where Self == PrimaryGlassButtonStyle {
    /// A Liquid Glass button style tinted with the primary color.
    static var primaryGlass: PrimaryGlassButtonStyle {
        PrimaryGlassButtonStyle()
    }
}
