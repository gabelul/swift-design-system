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
            // A multi-line label must keep its intrinsic height. Without this the
            // button hands the label less height than it needs at accessibility text
            // sizes, the label's last line renders outside the background shape, and
            // it collides with whatever sits below the button.
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(colorPalette.onPrimary)
            .padding(.horizontal, buttonSize.horizontalPadding)
            .frame(minHeight: buttonSize.height)
            // macOS sizes to content width (HIG: full-width fill is a watchOS idiom; macOS fits width to content).
            #if os(iOS)
            .frame(maxWidth: .infinity)
            #endif
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .fill(colorPalette.primary)
                    .opacity(isEnabled ? 1.0 : 0.6)
            )
            .elevation(.level2)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.6)
            .animate(motion.tap, value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    /// Primary button style.
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}
