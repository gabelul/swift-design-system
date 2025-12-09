import SwiftUI

/// Liquid Glass chip style.
///
/// Semi‑transparent chip style based on the Liquid Glass design language
/// announced at Apple WWDC 2024. Uses the official `.glassEffect()` API on
/// iOS 26+ to provide a premium appearance.
///
/// ## Example
/// ```swift
/// Chip("Premium", systemImage: "star.fill")
///     .chipStyle(.liquidGlass)
///     .foregroundColor(.yellow)
///
/// Chip("Featured", systemImage: "sparkles")
///     .chipStyle(.liquidGlass)
///     .foregroundColor(.purple)
/// ```
///
/// ## Visual characteristics
/// - Background: Liquid Glass effect (`.glassEffect()`)
/// - Dynamic adaptation: color responds to surrounding content
/// - Interactive: semi‑transparent effect that reacts to touch
/// - Animation: smooth tap feedback
///
/// ## System requirements
/// - iOS 26.0+
/// - macOS 26.0+
@available(iOS 26.0, macOS 26.0, *)
public struct LiquidGlassChipStyle: ChipStyle, Sendable {
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
                .fontWeight(.semibold)

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
        .background {
            Capsule()
                .fill(.clear)
                .glassEffect(.regular.interactive(true))
                .overlay {
                    if configuration.isSelected {
                        Capsule()
                            .fill(Color.primary.opacity(0.15))
                    }
                }
        }
        .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
        .animate(configuration.motion.tap, value: configuration.isPressed)
        .animate(configuration.motion.toggle, value: configuration.isSelected)
    }
}

@available(iOS 26.0, macOS 26.0, *)
public extension ChipStyle where Self == LiquidGlassChipStyle {
    /// Liquid Glass chip style.
    static var liquidGlass: LiquidGlassChipStyle {
        LiquidGlassChipStyle()
    }
}
