import SwiftUI

/// Secondary button style
///
/// Button style for auxiliary actions.
/// Uses SecondaryContainer color background for less emphasis than Primary, allowing multiple buttons on screen.
///
/// ## Usage Examples
/// ```swift
/// HStack {
///     Button("Cancel") {
///         cancel()
///     }
///     .buttonStyle(.secondary)
///
///     Button("Save") {
///         save()
///     }
///     .buttonStyle(.primary)
/// }
/// ```
///
/// ## Use Cases
/// - Cancel buttons
/// - Alternative actions
/// - Form reset buttons
public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.buttonSize) private var buttonSize
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.motion) private var motion

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .typography(buttonSize.typography)
            .foregroundStyle(colorPalette.onSecondaryContainer)
            .padding(.horizontal, buttonSize.horizontalPadding)
            .frame(minHeight: buttonSize.height)
            // macOS sizes to content width (HIG: full-width fill is a watchOS idiom; macOS fits width to content).
            #if os(iOS)
            .frame(maxWidth: .infinity)
            #endif
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .fill(colorPalette.secondaryContainer)
                    .opacity(isEnabled ? 1.0 : 0.6)
            )
            .elevation(.level1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.6)
            .animate(motion.tap, value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    /// Secondary button style
    static var secondary: SecondaryButtonStyle {
        SecondaryButtonStyle()
    }
}
