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
            // A multi-line label must keep its intrinsic height. Without this the
            // button hands the label less height than it needs at accessibility text
            // sizes, the label's last line renders outside the background shape, and
            // it collides with whatever sits below the button.
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(colorPalette.primary)
            .padding(.horizontal, buttonSize.horizontalPadding)
            .frame(minHeight: buttonSize.height)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.clear)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.6)
            .animate(motion.tap, value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == TertiaryButtonStyle {
    /// Tertiary button style
    static var tertiary: TertiaryButtonStyle {
        TertiaryButtonStyle()
    }
}
