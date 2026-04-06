import SwiftUI

/// Motion specification data model
struct MotionSpec: Identifiable, Sendable {
    let id: String
    let name: String
    let duration: String
    let easing: String
    let category: MotionCategory
    let usage: String
    let description: String
    let animation: @Sendable (Motion) -> Animation

    /// Motion category
    enum MotionCategory: String, CaseIterable {
        case microInteraction = "Micro-interaction"
        case stateChange = "State Change"
        case transition = "Transition"
        case spring = "Spring"

        var icon: String {
            switch self {
            case .microInteraction: return "hand.tap.fill"
            case .stateChange: return "arrow.triangle.2.circlepath"
            case .transition: return "arrow.left.arrow.right"
            case .spring: return "arrow.down.bounce"
            }
        }

        var description: String {
            switch self {
            case .microInteraction: return "For instant feedback (70-110ms)"
            case .stateChange: return "UI element state switching (150ms)"
            case .transition: return "Content movement and transformation (240-375ms)"
            case .spring: return "Natural physics-based motion"
            }
        }
    }

    /// All motion specifications
    static let all: [MotionSpec] = [
        // Micro-interactions
        MotionSpec(
            id: "quick",
            name: "quick",
            duration: "70ms",
            easing: "Ease-out",
            category: .microInteraction,
            usage: "Hover, cursor feedback",
            description: "Fastest animation. For micro-interactions.",
            animation: { $0.quick }
        ),
        MotionSpec(
            id: "tap",
            name: "tap",
            duration: "110ms",
            easing: "Ease-out",
            category: .microInteraction,
            usage: "Button press, tap feedback",
            description: "Immediate feedback for taps and button presses.",
            animation: { $0.tap }
        ),

        // State changes
        MotionSpec(
            id: "toggle",
            name: "toggle",
            duration: "150ms",
            easing: "Ease-in-out",
            category: .stateChange,
            usage: "Checkbox, selection state",
            description: "Used for toggles and state switching.",
            animation: { $0.toggle }
        ),
        MotionSpec(
            id: "fadeIn",
            name: "fadeIn",
            duration: "150ms",
            easing: "Ease-out",
            category: .stateChange,
            usage: "Displaying new content",
            description: "Element appearance, modal display.",
            animation: { $0.fadeIn }
        ),
        MotionSpec(
            id: "fadeOut",
            name: "fadeOut",
            duration: "150ms",
            easing: "Ease-in",
            category: .stateChange,
            usage: "Hiding content",
            description: "Element disappearance, modal closing.",
            animation: { $0.fadeOut }
        ),

        // Transitions
        MotionSpec(
            id: "slide",
            name: "slide",
            duration: "240ms",
            easing: "Ease-in-out",
            category: .transition,
            usage: "Tab switching, pagination",
            description: "Smooth content movement.",
            animation: { $0.slide }
        ),
        MotionSpec(
            id: "slow",
            name: "slow",
            duration: "300ms",
            easing: "Ease-in-out",
            category: .transition,
            usage: "Section expansion, theme switching",
            description: "Slow animation for context changes.",
            animation: { $0.slow }
        ),
        MotionSpec(
            id: "slower",
            name: "slower",
            duration: "375ms",
            easing: "Ease-in-out",
            category: .transition,
            usage: "Navigation transitions",
            description: "Slower animation for complex transitions.",
            animation: { $0.slower }
        ),

        // Springs
        MotionSpec(
            id: "spring",
            name: "spring",
            duration: "Response: 0.3s",
            easing: "Damping: 0.6",
            category: .spring,
            usage: "Drag & drop, scrolling",
            description: "Natural spring animation.",
            animation: { $0.spring }
        ),
        MotionSpec(
            id: "bounce",
            name: "bounce",
            duration: "Response: 0.5s",
            easing: "Damping: 0.5",
            category: .spring,
            usage: "Playful effects, success feedback",
            description: "Spring animation with bounce.",
            animation: { $0.bounce }
        )
    ]

    /// Group by category
    static func grouped() -> [MotionCategory: [MotionSpec]] {
        Dictionary(grouping: all, by: { $0.category })
    }
}
