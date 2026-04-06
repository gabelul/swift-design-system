import SwiftUI

/// Filled Chip Style
///
/// A Chip style with a filled background. Suitable for status displays,
/// category labels, and fixed information display.
///
/// ## Usage Example
/// ```swift
/// Chip("Active", systemImage: "circle.fill")
///     .chipStyle(.filled)
///     .foregroundColor(.green)
///
/// Chip("Premium", systemImage: "star.fill")
///     .chipStyle(.filled)
///     .foregroundColor(.orange)
/// ```
///
/// ## Visual Characteristics
/// - Background: 10% opacity of semantic color
/// - Text: Semantic color (full opacity)
/// - Corner radius: Design system's radiusScale.xs
/// - When selected: Background opacity increases to 20%
public struct FilledChipStyle: ChipStyle, Sendable {
    public init() {}

    public func makeBody(configuration: ChipStyleConfiguration) -> some View {
        HStack(spacing: configuration.spacingScale.xs) {
            // Leading icon
            if let icon = configuration.icon {
                icon
                    .font(.system(size: configuration.size.iconSize))
            }

            // Label
            configuration.label
                .typography(configuration.size.typography)
                .fontWeight(.medium)

            // Delete button
            if let onDelete = configuration.onDelete {
                Button(action: onDelete) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: configuration.size.iconSize))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, configuration.size.horizontalPadding)
        .padding(.vertical, configuration.size.verticalPadding)
        .frame(height: configuration.size.height)
        .background(
            backgroundOpacity(for: configuration)
        )
        .clipShape(Capsule())
        .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
        .animate(configuration.motion.tap, value: configuration.isPressed)
        .animate(configuration.motion.toggle, value: configuration.isSelected)
    }

    private func backgroundOpacity(for configuration: ChipStyleConfiguration) -> some ShapeStyle {
        configuration.colorPalette.primary.opacity(configuration.isSelected ? 0.2 : 0.1)
    }
}

public extension ChipStyle where Self == FilledChipStyle {
    /// Filled Chip style
    static var filled: FilledChipStyle {
        FilledChipStyle()
    }
}
