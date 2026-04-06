import SwiftUI

// MARK: - Animate Modifier

/// Animation modifier with automatic accessibility handling.
///
/// Applies animations when the bound value changes.
/// When the system “Reduce Motion” setting is enabled, animations are minimized.
///
/// ## Accessibility
/// - Conforms to WCAG 2.1 Success Criterion 2.3.3 (Animation from Interactions).
/// - When `accessibilityReduceMotion` is enabled, animations are reduced to an almost instant change (10ms).
/// - Users do not need to configure anything manually; appropriate animations are chosen automatically.
///
/// ## Example
/// ```swift
/// @Environment(\.motion) var motion
/// @State private var isPressed = false
///
/// Button("Tap") {
///     isPressed.toggle()
/// }
/// .scaleEffect(isPressed ? 0.98 : 1.0)
/// .animate(motion.tap, value: isPressed)
/// ```
///
/// ## Using together with Motion tokens
/// ```swift
/// // Fade in/out
/// Text("Message")
///     .opacity(isVisible ? 1 : 0)
///     .animate(motion.fadeIn, value: isVisible)
///
/// // Slide
/// SomeView()
///     .offset(x: selectedTab == .home ? 0 : -UIScreen.main.bounds.width)
///     .animate(motion.slide, value: selectedTab)
///
/// // Spring
/// Circle()
///     .offset(y: isDragging ? dragOffset : 0)
///     .animate(motion.spring, value: dragOffset)
/// ```
public struct AnimateModifier<V: Equatable>: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Animation to apply.
    let animation: Animation

    /// Value to observe (animation runs when this changes).
    let value: V

    /// Initializer.
    /// - Parameters:
    ///   - animation: Animation to apply (typically from a `Motion` implementation).
    ///   - value: Value to observe.
    public init(animation: Animation, value: V) {
        self.animation = animation
        self.value = value
    }

    public func body(content: Content) -> some View {
        content.animation(
            reduceMotion ? .linear(duration: 0.01) : animation,
            value: value
        )
    }
}

// MARK: - View Extension

public extension View {
    /// Applies an animation with automatic accessibility handling.
    ///
    /// Applies the given animation when the observed value changes.
    /// If the system “Reduce Motion” setting is enabled, the animation is minimized.
    ///
    /// - Parameters:
    ///   - animation: Animation to apply.
    ///   - value: Value to observe (animation runs when this changes).
    /// - Returns: A view with the animation applied.
    ///
    /// ## Recommended usage
    /// ```swift
    /// @Environment(\.motion) var motion
    ///
    /// // Button press feedback
    /// Button("Button") { }
    ///     .scaleEffect(isPressed ? 0.98 : 1.0)
    ///     .animate(motion.tap, value: isPressed)
    ///
    /// // State change
    /// Toggle("Settings", isOn: $isEnabled)
    ///     .foregroundColor(isEnabled ? .blue : .gray)
    ///     .animate(motion.toggle, value: isEnabled)
    /// ```
    func animate<V: Equatable>(_ animation: Animation, value: V) -> some View {
        modifier(AnimateModifier(animation: animation, value: value))
    }
}
