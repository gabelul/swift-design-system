import SwiftUI

/// Motion catalog view
struct MotionCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.motion) private var motion

    var body: some View {
        CatalogPageContainer(title: "Motion") {
            CatalogOverview(description: "Consistent animation timing throughout the design system")

            SectionCard(title: "Key Features") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    FeatureRow(icon: "accessibility", title: "Automatic accessibility support (WCAG 2.1 compliant)")
                    FeatureRow(icon: "chart.line.uptrend.xyaxis", title: "Industry standard compliance (Material Design 3, IBM Carbon)")
                    FeatureRow(icon: "swift", title: "SwiftUI native API")
                    FeatureRow(icon: "wand.and.stars", title: "10 optimized timing presets")
                }
            }

            // Demo by category
            ForEach(MotionSpec.MotionCategory.allCases, id: \.self) { category in
                categoryDemoSection(category: category)
            }

            SectionCard(title: "Specification Table") {
                VStack(spacing: 0) {
                    HStack(spacing: spacing.sm) {
                        Text("Name").frame(minWidth: 70, alignment: .leading)
                        Text("Duration").frame(minWidth: 80, alignment: .leading)
                        Text("Easing").frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .typography(.labelMedium)
                    .foregroundStyle(colors.onSurfaceVariant)
                    .padding(spacing.sm)
                    .background(colors.surfaceVariant.opacity(0.5))

                    ForEach(MotionSpec.all) { spec in
                        VStack(spacing: 0) {
                            HStack(spacing: spacing.sm) {
                                Text(spec.name)
                                    .typography(.bodyMedium)
                                    .foregroundStyle(colors.primary)
                                    .frame(minWidth: 70, alignment: .leading)

                                Text(spec.duration)
                                    .typography(.bodySmall)
                                    .foregroundStyle(colors.onSurface)
                                    .frame(minWidth: 80, alignment: .leading)

                                Text(spec.easing)
                                    .typography(.bodySmall)
                                    .foregroundStyle(colors.onSurfaceVariant)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(spacing.sm)

                            if spec.id != MotionSpec.all.last?.id {
                                Divider()
                            }
                        }
                    }
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    @Environment(\\.motion) var motion

                    Button("Tap") { }
                        .scaleEffect(isPressed ? 0.98 : 1.0)
                        .animate(motion.tap, value: isPressed)

                    // Multiple animations
                    Chip("Filter", isSelected: $selected)
                        .animate(motion.toggle, value: selected)

                    // Using with withAnimation
                    withAnimation(motion.slow) {
                        themeProvider.applyTheme(newTheme)
                    }
                    """)
            }

            SectionCard(title: "Best Practices") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Choose appropriate motion",
                        description: "Use tap for taps, toggle for state changes",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Use .animate() modifier",
                        description: "Always use for automatic Reduce Motion support",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "xmark.circle.fill",
                        title: "Avoid hardcoded values",
                        description: "Avoid .animation(.easeInOut(duration: 0.15))",
                        isGood: false
                    )
                }
            }
        }
    }

    private func categoryDemoSection(category: MotionSpec.MotionCategory) -> some View {
        let specs = MotionSpec.all.filter { $0.category == category }

        return SectionCard(title: category.rawValue) {
            VStack(alignment: .leading, spacing: spacing.md) {
                Text(category.description)
                    .typography(.bodySmall)
                    .foregroundStyle(colors.onSurfaceVariant)

                AspectGrid(
                    minItemWidth: 160,
                    maxItemWidth: 240,
                    itemAspectRatio: 0.85,
                    spacing: .md
                ) {
                    ForEach(specs) { spec in
                        MotionDemoCard(spec: spec)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MotionCatalogView()
            .theme(ThemeProvider())
    }
}
