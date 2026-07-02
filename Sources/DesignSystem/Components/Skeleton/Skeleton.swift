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

// MARK: - Redacted content skeleton

public extension View {
    /// Skeleton loading effect for real content: a `redacted` placeholder with a
    /// soft-light highlight band sweeping across it.
    ///
    /// Apply `.skeleton(isRedacted: isLoading)` directly to real content, or to a
    /// group of placeholder shapes. Internally guarded so the animation isn't
    /// overridden by the parent view's animation transaction.
    ///
    /// Source: Kavsoft "SwiftUI Skeleton View - Skeleton Loading Animations" (2025-04)
    /// - Parameters:
    ///   - isRedacted: Whether the skeleton is currently shown.
    ///   - tint: Color of the highlight band. `nil` falls back to white/black based on color scheme.
    func skeleton(isRedacted: Bool, tint: Color? = nil) -> some View {
        modifier(SkeletonModifier(isRedacted: isRedacted, tint: tint))
    }
}

struct SkeletonModifier: ViewModifier {
    var isRedacted: Bool
    var tint: Color?
    @Environment(\.colorScheme) private var scheme

    func body(content: Content) -> some View {
        content
            .redacted(reason: isRedacted ? .placeholder : [])
            .overlay {
                if isRedacted {
                    // Time-driven (TimelineView): @State + withAnimation(.repeatForever) is
                    // fragile — ancestor re-renders and insertion transitions can kill the
                    // animation. Deriving position from the clock every frame keeps it
                    // running no matter what triggers a re-render.
                    TimelineView(.animation) { timeline in
                        GeometryReader {
                            let size = $0.size
                            let skeletonWidth = size.width / 2
                            // Guarantee a blur radius of at least 30
                            let blurRadius = max(skeletonWidth / 2, 30)
                            let blurDiameter = blurRadius * 2
                            // Travel endpoints
                            let minX = -(skeletonWidth + blurDiameter)
                            let maxX = size.width + skeletonWidth + blurDiameter
                            let progress = Self.easeInOut(
                                timeline.date.timeIntervalSinceReferenceDate
                                    .truncatingRemainder(dividingBy: period) / period
                            )

                            Rectangle()
                                .fill(tint ?? (scheme == .dark ? .white : .black))
                                .frame(width: skeletonWidth, height: size.height * 2)
                                .frame(height: size.height)
                                .blur(radius: blurRadius)
                                .rotationEffect(.degrees(rotation))
                                // Sweep infinitely from left to right
                                .offset(x: minX + (maxX - minX) * progress)
                        }
                    }
                    .mask {
                        content
                            .redacted(reason: .placeholder)
                    }
                    .blendMode(.softLight)
                }
            }
    }

    var rotation: Double { 5 }
    var period: Double { 1.5 }

    /// Matches the easing of the legacy `.easeInOut(duration: 1.5)` implementation.
    private static func easeInOut(_ t: Double) -> Double {
        t < 0.5 ? 2 * t * t : 1 - pow(-2 * t + 2, 2) / 2
    }
}

#Preview("Redacted content") {
    VStack(alignment: .leading, spacing: 12) {
        HStack(spacing: 12) {
            Circle().frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 6) {
                RoundedRectangle(cornerRadius: 4).frame(width: 140, height: 12)
                RoundedRectangle(cornerRadius: 4).frame(width: 90, height: 10)
            }
        }
        RoundedRectangle(cornerRadius: 12).frame(height: 120)
    }
    .foregroundStyle(.gray.opacity(0.3))
    .skeleton(isRedacted: true)
    .padding()
}
