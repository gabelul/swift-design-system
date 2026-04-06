import SwiftUI

/// Adds a shimmer animation effect to any view
///
/// A moving gradient sweeps across the view to indicate loading.
/// Automatically falls back to a pulsing opacity effect when
/// the user has enabled "Reduce Motion" in accessibility settings.
///
/// ## Usage
/// ```swift
/// // On a skeleton placeholder
/// RoundedRectangle(cornerRadius: 8)
///     .fill(Color.gray.opacity(0.2))
///     .frame(height: 20)
///     .shimmer()
///
/// // Conditionally
/// content.shimmer(isActive: isLoading)
/// ```
struct ShimmerModifier: ViewModifier {
    @Environment(\.colorPalette) private var colors
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var phase: CGFloat = -0.6
    @State private var pulse: Bool = false

    let isActive: Bool

    func body(content: Content) -> some View {
        if isActive {
            if reduceMotion {
                content
                    .opacity(pulse ? 0.85 : 1.0)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                            pulse.toggle()
                        }
                    }
            } else {
                content
                    .overlay(gradientMask.mask(content))
                    .onAppear {
                        phase = -0.6
                        withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                            phase = 1.2
                        }
                    }
            }
        } else {
            content
        }
    }

    private var gradientMask: LinearGradient {
        let highlight = colors.onSurface
        return LinearGradient(
            gradient: Gradient(colors: [
                highlight.opacity(0.0),
                highlight.opacity(0.25),
                highlight.opacity(0.0),
            ]),
            startPoint: UnitPoint(x: max(-1, min(phase, 1)), y: max(-1, min(phase, 1))),
            endPoint: UnitPoint(x: max(-1, min(phase + 0.4, 1.4)), y: max(-1, min(phase + 0.4, 1.4)))
        )
    }
}

public extension View {
    /// Applies a shimmer loading animation to this view
    ///
    /// - Parameter isActive: Whether the shimmer is animating (default: true)
    func shimmer(isActive: Bool = true) -> some View {
        modifier(ShimmerModifier(isActive: isActive))
    }
}
