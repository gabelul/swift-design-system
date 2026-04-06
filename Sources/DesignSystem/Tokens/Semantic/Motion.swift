import SwiftUI

/// Motion timing definitions.
///
/// Predefined animation timings that provide consistent motion across the design system.
/// Values are based on industry standards such as Material Design 3, IBM Carbon Design System,
/// and Apple Human Interface Guidelines.
///
/// ## Example
/// ```swift
/// @Environment(\.motion) var motion
///
/// Button("Tap") { }
///     .scaleEffect(isPressed ? 0.98 : 1.0)
///     .animate(motion.tap, value: isPressed)
/// ```
///
/// ## Categories
/// - **Micro Interactions**: `quick`, `tap` – instant feedback (70–110ms)
/// - **State Changes**: `toggle`, `fadeIn`, `fadeOut` – UI state changes (~150ms)
/// - **Transitions**: `slide`, `slow`, `slower` – content transitions (240–375ms)
/// - **Springs**: `spring`, `bounce` – natural, physics‑based motion
///
/// ## Accessibility
/// When used via the `.animate()` modifier, animations are automatically minimized when
/// “Reduce Motion” is enabled (WCAG 2.1 compliant).
public protocol Motion: Sendable {
    // MARK: - Micro-interactions

    /// Fastest animation – for micro interactions.
    ///
    /// Ideal for hover effects, cursor feedback, and other instant visual responses.
    /// - Duration: 70ms
    /// - Easing: Ease‑out
    var quick: Animation { get }

    /// Tap/press animation.
    ///
    /// Used for button presses, switch toggles, and other direct user interactions.
    /// - Duration: 110ms
    /// - Easing: Ease‑out
    var tap: Animation { get }

    // MARK: - State Changes

    /// Toggle / state change animation.
    ///
    /// Used for checkboxes, selection changes, and active/inactive toggles.
    /// - Duration: 150ms
    /// - Easing: Ease‑in‑out
    var toggle: Animation { get }

    /// Fade‑in – element appearance.
    ///
    /// Used for showing new content, presenting modals, and alerts.
    /// - Duration: 150ms
    /// - Easing: Ease‑out
    var fadeIn: Animation { get }

    /// Fade‑out – element disappearance.
    ///
    /// Used for hiding content, dismissing modals, and clearing notifications.
    /// - Duration: 150ms
    /// - Easing: Ease‑in
    var fadeOut: Animation { get }

    // MARK: - Transitions

    /// Slide – position change.
    ///
    /// Used for tab switching, pagination, carousels, and smooth content movement.
    /// - Duration: 240ms
    /// - Easing: Ease‑in‑out
    var slide: Animation { get }

    /// Slower animation – for context changes.
    ///
    /// Used for section expansion, complex layout changes, full‑screen transitions.
    /// - Duration: 300ms
    /// - Easing: Ease‑in‑out
    var slow: Animation { get }

    /// Slowest non‑spring animation – for complex transitions.
    ///
    /// Used for navigation transitions, large layout shifts, and coordinated motion.
    /// - Duration: 375ms
    /// - Easing: Ease‑in‑out
    var slower: Animation { get }

    // MARK: - Spring Animations

    /// Natural spring animation.
    ///
    /// Used for drag‑and‑drop release, settling after scroll, and elastic motion.
    /// - Response: 0.3s
    /// - Damping: 0.6 (moderate bounce)
    var spring: Animation { get }

    /// Spring animation with bounce.
    ///
    /// Used when you want playful motion, success feedback, or attention‑grabbing effects.
    /// - Response: 0.5s
    /// - Damping: 0.5 (stronger bounce)
    var bounce: Animation { get }
}

// MARK: - Default Implementation

/// Default Motion implementation.
///
/// Production‑ready animation timings based on Material Design 3 and IBM Carbon Design System.
public struct DefaultMotion: Motion {
    public init() {}

    // MARK: - Micro-interactions

    public var quick: Animation {
        .easeOut(duration: 0.07)
    }

    public var tap: Animation {
        .easeOut(duration: 0.11)
    }

    // MARK: - State Changes

    public var toggle: Animation {
        .easeInOut(duration: 0.15)
    }

    public var fadeIn: Animation {
        .easeOut(duration: 0.15)
    }

    public var fadeOut: Animation {
        .easeIn(duration: 0.15)
    }

    // MARK: - Transitions

    public var slide: Animation {
        .easeInOut(duration: 0.24)
    }

    public var slow: Animation {
        .easeInOut(duration: 0.30)
    }

    public var slower: Animation {
        .easeInOut(duration: 0.375)
    }

    // MARK: - Spring Animations

    public var spring: Animation {
        .spring(response: 0.3, dampingFraction: 0.6)
    }

    public var bounce: Animation {
        .spring(response: 0.5, dampingFraction: 0.5)
    }
}
