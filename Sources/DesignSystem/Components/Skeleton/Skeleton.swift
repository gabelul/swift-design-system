import SwiftUI

/// Shape presets for skeleton placeholders
public enum SkeletonShape {
    /// Standard rectangle (default)
    case rectangle
    /// Circle (for avatars)
    case circle
    /// Capsule (for pills/tags)
    case capsule
    /// Rounded rectangle with custom corner radius
    case roundedRectangle(cornerRadius: CGFloat)
}

/// Placeholder loading view with shimmer animation
///
/// Renders a neutral shape with a shimmer sweep to indicate
/// content is loading. Combine with layout containers to build
/// full skeleton screens.
///
/// ## Usage
/// ```swift
/// // Simple rectangle
/// Skeleton()
///     .frame(height: 20)
///
/// // Circle for avatar
/// Skeleton(.circle)
///     .frame(width: 48, height: 48)
///
/// // Build a skeleton screen
/// VStack(alignment: .leading, spacing: 12) {
///     HStack(spacing: 12) {
///         Skeleton(.circle).frame(width: 48, height: 48)
///         VStack(alignment: .leading, spacing: 8) {
///             Skeleton().frame(height: 16)
///             Skeleton().frame(width: 120, height: 12)
///         }
///     }
///     Skeleton().frame(height: 200)
/// }
/// ```
public struct Skeleton: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.radiusScale) private var radius

    private let shape: SkeletonShape

    /// Creates a skeleton placeholder
    ///
    /// - Parameter shape: The shape of the placeholder (default: .rectangle)
    public init(_ shape: SkeletonShape = .rectangle) {
        self.shape = shape
    }

    public var body: some View {
        shapeView
            .shimmer()
    }

    @ViewBuilder
    private var shapeView: some View {
        switch shape {
        case .rectangle:
            RoundedRectangle(cornerRadius: radius.sm)
                .fill(colors.surfaceVariant)
        case .circle:
            Circle()
                .fill(colors.surfaceVariant)
        case .capsule:
            Capsule()
                .fill(colors.surfaceVariant)
        case .roundedRectangle(let cornerRadius):
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(colors.surfaceVariant)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        // Avatar + text skeleton
        HStack(spacing: 12) {
            Skeleton(.circle)
                .frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 8) {
                Skeleton().frame(height: 16)
                Skeleton().frame(width: 120, height: 12)
            }
        }

        // Card skeleton
        Skeleton(.roundedRectangle(cornerRadius: 12))
            .frame(height: 200)

        // Text lines
        Skeleton().frame(height: 14)
        Skeleton().frame(height: 14)
        Skeleton().frame(width: 200, height: 14)
    }
    .padding()
    .theme(ThemeProvider())
}
