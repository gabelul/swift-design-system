import SwiftUI

/// A subdued button style that keeps the primary hue.
///
/// Use it for supporting actions tied to a primary flow — anywhere you want
/// an affinity with Primary without the visual weight of a filled Primary
/// button.
public struct PrimaryTonalButtonStyle: ButtonStyle {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.buttonSize) private var buttonSize
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.motion) private var motion

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .typography(buttonSize.typography)
            .foregroundStyle(colorPalette.onPrimaryContainer)
            .padding(.horizontal, buttonSize.horizontalPadding)
            .frame(height: buttonSize.height)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .fill(colorPalette.primaryContainer)
                    .overlay {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(colorPalette.primary.opacity(0.18), lineWidth: 1)
                    }
                    .opacity(isEnabled ? 1.0 : 0.6)
            }
            .elevation(.level1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.6)
            .animate(motion.tap, value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == PrimaryTonalButtonStyle {
    /// A subdued button style that keeps the primary hue.
    static var primaryTonal: PrimaryTonalButtonStyle {
        PrimaryTonalButtonStyle()
    }
}
