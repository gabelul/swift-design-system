import SwiftUI

/// StepIndicator Component
///
/// A mini indicator that represents the current position among N forward-only steps
/// as a row of dots. The current step is filled with `primary`, passed steps with a
/// faded `primary`, and future steps with `outlineVariant`.
///
/// ## Basic Usage Examples
/// ```swift
/// // Step 2 of 3 (index 1) is in progress
/// StepIndicator(stepCount: 3, currentIndex: 1)
///
/// // All steps completed (nil = no active position)
/// StepIndicator(stepCount: 3, currentIndex: nil)
/// ```
///
/// The accessibility label is auto-generated in the form "Step 2 of 3".
/// If a step has its own name, override it with `accessibilityText`.
public struct StepIndicator: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.motion) private var motion

    private let stepCount: Int
    private let currentIndex: Int?
    private let accessibilityText: String?
    private let dotDiameter: CGFloat

    /// Creates a step indicator
    /// - Parameters:
    ///   - stepCount: Total number of steps
    ///   - currentIndex: Current step (0-based). nil = all steps completed
    ///   - accessibilityText: Override for the accessibility label (nil = "Step N of M")
    ///   - dotDiameter: Dot diameter (default 6pt)
    public init(
        stepCount: Int,
        currentIndex: Int?,
        accessibilityText: String? = nil,
        dotDiameter: CGFloat = 6
    ) {
        self.stepCount = stepCount
        self.currentIndex = currentIndex
        self.accessibilityText = accessibilityText
        self.dotDiameter = dotDiameter
    }

    public var body: some View {
        HStack(spacing: spacing.xs) {
            ForEach(0..<stepCount, id: \.self) { index in
                Circle()
                    .fill(color(for: index))
                    .frame(width: dotDiameter, height: dotDiameter)
            }
        }
        .animate(motion.toggle, value: currentIndex)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityText ?? defaultAccessibilityText)
    }

    private func color(for index: Int) -> Color {
        guard let currentIndex else { return colors.outlineVariant }
        if index < currentIndex { return colors.primary.opacity(0.35) }
        if index == currentIndex { return colors.primary }
        return colors.outlineVariant
    }

    private var defaultAccessibilityText: String {
        guard let currentIndex else { return "Completed" }
        return "Step \(currentIndex + 1) of \(stepCount)"
    }
}

// MARK: - Previews

#Preview("Step Indicator") {
    VStack(spacing: 24) {
        StepIndicator(stepCount: 3, currentIndex: 0)
        StepIndicator(stepCount: 3, currentIndex: 1)
        StepIndicator(stepCount: 3, currentIndex: 2)
        StepIndicator(stepCount: 3, currentIndex: nil)
        StepIndicator(stepCount: 5, currentIndex: 2, dotDiameter: 8)
    }
    .padding()
    .theme(ThemeProvider())
}
