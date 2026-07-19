import SwiftUI

/// Primary button style.
///
/// The most prominent button style, used for primary actions on a screen
/// (log in, submit, save, etc.). Uses the primary color as the background with
/// white text and applies a scale animation on press.
///
/// ## Example
/// ```swift
/// Button("Log in") {
///     login()
/// }
/// .buttonStyle(.primary)
/// .buttonSize(.large)  // Optional size
///
/// Button("Save") {
///     save()
/// }
/// .buttonStyle(.primary)
/// .buttonSize(.medium)
/// ```
///
/// ## When to use each style
/// - **Primary**: Most important action (recommended at most one per screen).
/// - **Secondary**: Supporting actions.
/// - **Tertiary**: Less prominent actions.
public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.buttonSize) private var buttonSize
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.motion) private var motion

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .typography(buttonSize.typography)
            .foregroundStyle(colorPalette.onPrimary)
            .padding(.horizontal, buttonSize.horizontalPadding)
            .frame(minHeight: buttonSize.height)
            // macOS sizes to content width (HIG: full-width fill is a watchOS idiom; macOS fits width to content).
            #if os(iOS)
            .frame(maxWidth: .infinity)
            #endif
            .background(
                RoundedRectangle(cornerRadius: buttonSize.cornerRadius)
                    .fill(colorPalette.primary)
                    .opacity(isEnabled ? 1.0 : 0.6)
            )
            .elevation(.level2)
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

public extension ButtonStyle where Self == PrimaryButtonStyle {
    /// Primary button style.
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}
