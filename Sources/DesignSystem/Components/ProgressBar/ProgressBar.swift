import SwiftUI

/// A customizable progress bar component
///
/// Displays progress as a horizontal bar with configurable appearance.
/// Supports solid colors, gradients, animation, and various size options.
///
/// ## Usage
/// ```swift
/// // Simple progress
/// ProgressBar(value: 0.75)
///
/// // With gradient
/// ProgressBar(value: 0.5, gradient: .init(colors: [.blue, .purple]))
///
/// // Animated progress
/// ProgressBar(value: progress, animated: true)
/// ```
public struct ProgressBar: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.radiusScale) private var radiusScale

    private let value: Double
    private let height: CGFloat
    private let cornerRadius: CGFloat?
    private let foregroundColor: Color?
    private let gradient: LinearGradient?
    private let backgroundColor: Color?
    private let animated: Bool
    private let animation: Animation

    /// Creates a progress bar with a solid color
    /// - Parameters:
    ///   - value: Progress value (0.0 to 1.0)
    ///   - height: Bar height in points (default: 8)
    ///   - cornerRadius: Custom corner radius (default: uses height / 2)
    ///   - foregroundColor: Fill color (default: primary color)
    ///   - backgroundColor: Track color (default: surfaceVariant)
    ///   - animated: Whether to animate value changes (default: false)
    ///   - animation: Animation to use when animated is true (default: .easeInOut(duration: 0.3))
    public init(
        value: Double,
        height: CGFloat = 8,
        cornerRadius: CGFloat? = nil,
        foregroundColor: Color? = nil,
        backgroundColor: Color? = nil,
        animated: Bool = false,
        animation: Animation = .easeInOut(duration: 0.3)
    ) {
        self.value = min(max(value, 0), 1)
        self.height = height
        self.cornerRadius = cornerRadius
        self.foregroundColor = foregroundColor
        self.gradient = nil
        self.backgroundColor = backgroundColor
        self.animated = animated
        self.animation = animation
    }

    /// Creates a progress bar with a gradient fill
    /// - Parameters:
    ///   - value: Progress value (0.0 to 1.0)
    ///   - gradient: Gradient for the fill
    ///   - height: Bar height in points (default: 8)
    ///   - cornerRadius: Custom corner radius (default: uses height / 2)
    ///   - backgroundColor: Track color (default: surfaceVariant)
    ///   - animated: Whether to animate value changes (default: false)
    ///   - animation: Animation to use when animated is true (default: .easeInOut(duration: 0.3))
    public init(
        value: Double,
        gradient: LinearGradient,
        height: CGFloat = 8,
        cornerRadius: CGFloat? = nil,
        backgroundColor: Color? = nil,
        animated: Bool = false,
        animation: Animation = .easeInOut(duration: 0.3)
    ) {
        self.value = min(max(value, 0), 1)
        self.height = height
        self.cornerRadius = cornerRadius
        self.foregroundColor = nil
        self.gradient = gradient
        self.backgroundColor = backgroundColor
        self.animated = animated
        self.animation = animation
    }

    public var body: some View {
        GeometryReader { geometry in
            let radius = cornerRadius ?? (height / 2)
            let fillWidth = geometry.size.width * value

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: radius)
                    .fill(backgroundColor ?? colorPalette.surfaceVariant)
                    .frame(height: height)

                if let gradient {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(gradient)
                        .frame(width: max(fillWidth, 0), height: height)
                } else {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(foregroundColor ?? colorPalette.primary)
                        .frame(width: max(fillWidth, 0), height: height)
                }
            }
        }
        .frame(height: height)
        .animation(animated ? animation : nil, value: value)
    }
}

#Preview("Default") {
    VStack(spacing: 20) {
        ProgressBar(value: 0.25)
        ProgressBar(value: 0.5)
        ProgressBar(value: 0.75)
        ProgressBar(value: 1.0)
    }
    .padding()
    .theme(ThemeProvider())
}

#Preview("Gradient") {
    VStack(spacing: 20) {
        ProgressBar(
            value: 0.6,
            gradient: LinearGradient(
                colors: [.blue, .purple],
                startPoint: .leading,
                endPoint: .trailing
            )
        )

        ProgressBar(
            value: 0.8,
            gradient: LinearGradient(
                colors: [.orange, .red],
                startPoint: .leading,
                endPoint: .trailing
            ),
            height: 12
        )
    }
    .padding()
    .theme(ThemeProvider())
}

#Preview("Custom Heights") {
    VStack(spacing: 20) {
        ProgressBar(value: 0.5, height: 4)
        ProgressBar(value: 0.5, height: 8)
        ProgressBar(value: 0.5, height: 16)
        ProgressBar(value: 0.5, height: 24)
    }
    .padding()
    .theme(ThemeProvider())
}

#Preview("Animated") {
    struct AnimatedDemo: View {
        @State private var progress: Double = 0.0

        var body: some View {
            VStack(spacing: 24) {
                ProgressBar(
                    value: progress,
                    gradient: LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    height: 12,
                    animated: true
                )

                ProgressBar(
                    value: progress,
                    height: 8,
                    animated: true,
                    animation: .spring(duration: 0.5, bounce: 0.2)
                )

                Button("Toggle Progress") {
                    progress = progress < 0.5 ? 1.0 : 0.0
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }

    return AnimatedDemo()
        .theme(ThemeProvider())
}
