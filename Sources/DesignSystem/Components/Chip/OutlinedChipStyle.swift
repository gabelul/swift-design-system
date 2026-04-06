import SwiftUI

/// Outlined Chip Style
///
/// A Chip style with only a border. Suitable for filter selection,
/// secondary categories, and subtle information display.
///
/// ## Usage Example
/// ```swift
/// Chip("Filter", systemImage: "line.3.horizontal.decrease", isSelected: $isFiltered)
///     .chipStyle(.outlined)
///
/// Chip("Category", systemImage: "tag")
///     .chipStyle(.outlined)
///     .foregroundColor(.blue)
/// ```
///
/// ## Visual Characteristics
/// - Background: Transparent (10% opacity when selected)
/// - Border: 1.5pt, outline color
/// - Text: Semantic color
/// - Corner radius: Design system's radiusScale.xs
/// - When selected: Background and border colors are emphasized
public struct OutlinedChipStyle: ChipStyle, Sendable {
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
            configuration.isSelected
                ? Color.primary.opacity(0.1)
                : Color.clear
        )
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .strokeBorder(
                    configuration.isSelected
                        ? Color.primary
                        : configuration.colorPalette.outline,
                    lineWidth: 1.5
                )
        )
        .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
        .animate(configuration.motion.tap, value: configuration.isPressed)
        .animate(configuration.motion.toggle, value: configuration.isSelected)
    }
}

public extension ChipStyle where Self == OutlinedChipStyle {
    /// Outlined Chip style
    static var outlined: OutlinedChipStyle {
        OutlinedChipStyle()
    }
}
