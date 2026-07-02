import SwiftUI

public extension View {
    /// A shine effect where a glossy band tilted 45 degrees sweeps across the view.
    ///
    /// Runs once per change of `trigger`. For a repeating shine, have the
    /// caller toggle `trigger` at a regular interval.
    ///
    /// Source: Kavsoft "SwiftUI Shine Effect - Custom View Modifier" (2023-11)
    @ViewBuilder
    func shine(_ toggle: Bool, duration: CGFloat = 0.5, clipShape: some Shape = .rect, rightToLeft: Bool = false) -> some View {
        self
            .overlay {
                GeometryReader {
                    let size = $0.size
                    // Reject negative or vanishingly small durations
                    let moddedDuration = max(0.3, duration)
                    // The 45° rotation + scaleEffect(y: 8) stretches the band diagonally,
                    // so the travel distance adds height on top of width (prevents the
                    // band lingering on tall views — a fix on top of the source).
                    let travel = size.width + size.height

                    Rectangle()
                        .fill(.linearGradient(
                            colors: [
                                .clear,
                                .clear,
                                .white.opacity(0.1),
                                .white.opacity(0.5),
                                .white.opacity(1),
                                .white.opacity(0.5),
                                .white.opacity(0.1),
                                .clear,
                                .clear,
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .scaleEffect(y: 8)
                        .keyframeAnimator(initialValue: 0.0, trigger: toggle, content: { content, progress in
                            content
                                .offset(x: -travel + (progress * (travel * 2)))
                        }, keyframes: { _ in
                            CubicKeyframe(.zero, duration: 0.1)
                            CubicKeyframe(1, duration: moddedDuration)
                        })
                        .rotationEffect(.degrees(45))
                        .scaleEffect(x: rightToLeft ? -1 : 1)
                }
                .allowsHitTesting(false)
            }
            .clipShape(clipShape)
            .contentShape(clipShape)
    }
}
