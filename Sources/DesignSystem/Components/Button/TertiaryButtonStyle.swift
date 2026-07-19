import SwiftUI

/// Tertiary button style
///
/// The most subtle button style. No background, text color only.
/// Used for light actions like links, or operations that shouldn't be overly emphasized.
///
/// ## Usage Examples
/// ```swift
/// Button("View Details") {
///     showDetail()
/// }
/// .buttonStyle(.tertiary)
///
/// Button("Skip") {
///     skip()
/// }
/// .buttonStyle(.tertiary)
/// .buttonSize(.small)
/// ```
///
/// ## Use Cases
/// - Detail links
/// - Skip buttons
/// - Optional actions
/// - Inline operations
public struct TertiaryButtonStyle: ButtonStyle {
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
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: buttonSize.cornerRadius)
                    .fill(Color.clear)
            )
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
}

public extension ButtonStyle where Self == TertiaryButtonStyle {
    /// Tertiary button style
    static var tertiary: TertiaryButtonStyle {
        TertiaryButtonStyle()
    }
}
