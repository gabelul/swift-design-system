import SwiftUI

/// Motion catalog view
///
/// Comprehensive catalog of animation timing and the motion system
struct MotionCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing
    @Environment(\.motion) private var motion

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // 1. Overview
                overviewSection

                // 2. Interactive demos
                interactiveDemosSection

                // 3. Specifications
                specificationsSection

                // 4. Usage examples
                usageExamplesSection

                // 5. Accessibility
                accessibilitySection

                // 6. Best practices
                bestPracticesSection
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("Motion")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    // MARK: - 1. Overview

    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: spacing.lg) {
            VStack(alignment: .leading, spacing: spacing.sm) {
                Text("Motion system")
                    .typography(.headlineMedium)
                    .foregroundStyle(colorPalette.onSurface)

                Text("Provides consistent animation timing across the design system. Values are optimized based on industry standards such as Material Design 3, IBM Carbon Design System, and Apple Human Interface Guidelines.")
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
            }
            .padding(.horizontal, spacing.lg)
            .padding(.top, spacing.lg)

            // Key features
            VStack(alignment: .leading, spacing: spacing.md) {
                Text("Key features")
                    .typography(.titleMedium)
                    .foregroundStyle(colorPalette.onSurface)

                VStack(alignment: .leading, spacing: spacing.sm) {
                    FeatureRow(icon: "accessibility", title: "Automatic accessibility handling (WCAG 2.1 compliant)")
                    FeatureRow(icon: "chart.line.uptrend.xyaxis", title: "Aligned with industry standards (Material Design 3, IBM Carbon)")
                    FeatureRow(icon: "swift", title: "SwiftUI-native APIs")
                    FeatureRow(icon: "wand.and.stars", title: "10 optimized timing presets")
                }
            }
            .padding(.horizontal, spacing.lg)
        }
    }

    // MARK: - 2. Interactive demos

    private var interactiveDemosSection: some View {
        VStack(alignment: .leading, spacing: spacing.lg) {
            Text("Interactive demos")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)
                .padding(.horizontal, spacing.lg)

            Text("Try each motion preset in action. Tap the “Run animation” button to see the differences.")
                .typography(.bodyMedium)
                .foregroundStyle(colorPalette.onSurfaceVariant)
                .padding(.horizontal, spacing.lg)

            // Demos by category
            ForEach(MotionSpec.MotionCategory.allCases, id: \.self) { category in
                categoryDemoSection(category: category)
            }
        }
    }

    private func categoryDemoSection(category: MotionSpec.MotionCategory) -> some View {
        let specs = MotionSpec.all.filter { $0.category == category }

        return VStack(alignment: .leading, spacing: spacing.md) {
            HStack(spacing: spacing.sm) {
                Image(systemName: category.icon)
                    .font(.title3)
                    .foregroundStyle(colorPalette.primary)

                VStack(alignment: .leading, spacing: 2) {
                    Text(category.rawValue)
                        .typography(.titleMedium)
                        .foregroundStyle(colorPalette.onSurface)

                    Text(category.description)
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                }

                Spacer()
            }
            .padding(.horizontal, spacing.lg)

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
            .padding(.horizontal, spacing.lg)
        }
    }

    // MARK: - 3. 仕様表セクション

    private var specificationsSection: some View {
        VStack(alignment: .leading, spacing: spacing.lg) {
            Text("仕様表")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)
                .padding(.horizontal, spacing.lg)

            Text("全10モーションの詳細スペック")
                .typography(.bodyMedium)
                .foregroundStyle(colorPalette.onSurfaceVariant)
                .padding(.horizontal, spacing.lg)

            SectionCard(title: "All motion specifications") {
                VStack(spacing: 0) {
                    // Header
                    HStack(spacing: spacing.sm) {
                        Text("Name")
                            .frame(minWidth: 70, alignment: .leading)
                        Text("Duration")
                            .frame(minWidth: 80, alignment: .leading)
                        Text("Easing")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .typography(.labelMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(spacing.sm)
                    .background(colorPalette.surfaceVariant.opacity(0.5))

                    // 各行
                    ForEach(MotionSpec.all) { spec in
                        VStack(spacing: 0) {
                            HStack(spacing: spacing.sm) {
                                Text(spec.name)
                                    .typography(.bodyMedium)
                                    .foregroundStyle(colorPalette.primary)
                                    .frame(minWidth: 70, alignment: .leading)

                                Text(spec.duration)
                                    .typography(.bodySmall)
                                    .foregroundStyle(colorPalette.onSurface)
                                    .frame(minWidth: 80, alignment: .leading)

                                Text(spec.easing)
                                    .typography(.bodySmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
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
        }
    }

    // MARK: - 4. Usage examples

    private var usageExamplesSection: some View {
        VStack(alignment: .leading, spacing: spacing.lg) {
            Text("Usage examples")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)
                .padding(.horizontal, spacing.lg)

            // Basic usage
            SectionCard(title: "1. Basic usage") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("Access Motion via @Environment(\\.motion) and apply it with the .animate() modifier.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)

                    codeBlock("""
                    @Environment(\\.motion) var motion

                    Button("Tap") { }
                        .scaleEffect(isPressed ? 0.98 : 1.0)
                        .animate(motion.tap, value: isPressed)
                    """)
                }
            }

            // Multiple animations
            SectionCard(title: "2. Multiple animations") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("You can apply multiple .animate() modifiers to a single view.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)

                    codeBlock("""
                    Chip("Filter", isSelected: $selected)
                        .scaleEffect(isPressed ? 0.96 : 1.0)
                        .animate(motion.tap, value: isPressed)
                        .animate(motion.toggle, value: selected)
                    """)
                }
            }

            // Using withAnimation
            SectionCard(title: "3. Using withAnimation") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("You can also use Motion together with withAnimation.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)

                    codeBlock("""
                    withAnimation(motion.slow) {
                        themeProvider.applyTheme(newTheme)
                    }
                    """)
                }
            }
        }
    }

    // MARK: - 5. Accessibility

    private var accessibilitySection: some View {
        VStack(alignment: .leading, spacing: spacing.lg) {
            Text("Accessibility")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)
                .padding(.horizontal, spacing.lg)

            SectionCard(title: "Automatic Reduce Motion support") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("The `.animate()` modifier automatically respects the system “Reduce Motion” setting and minimizes animations when it is enabled (WCAG 2.1 Success Criterion 2.3.3 compliant).")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurface)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading, spacing: spacing.sm) {
                        FeatureRow(icon: "checkmark.circle.fill", title: "No manual configuration required")
                        FeatureRow(icon: "checkmark.circle.fill", title: "Fully compliant with WCAG 2.1")
                        FeatureRow(icon: "checkmark.circle.fill", title: "Consistent behavior across all motion presets")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Implementation example:")
                        .typography(.labelLarge)
                        .foregroundStyle(colorPalette.onSurface)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    codeBlock("""
                    // Automatically respects Reduce Motion
                    .animate(motion.tap, value: isPressed)

                    // Normal mode: uses the specified animation
                    // Reduce Motion: performs an instant 10ms change
                    """)
                }
            }
        }
    }

    // MARK: - 6. Best practices

    private var bestPracticesSection: some View {
        VStack(alignment: .leading, spacing: spacing.lg) {
            Text("Best practices")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)
                .padding(.horizontal, spacing.lg)

            // Recommended patterns
            SectionCard(title: "✓ Recommended patterns") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Choose appropriate motion",
                        description: "Use tap for taps, toggle for state changes.",
                        isGood: true
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Divider()

                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Use the .animate() modifier",
                        description: "Always use .animate() to get automatic Reduce Motion support.",
                        isGood: true
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Divider()

                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Maintain consistency",
                        description: "Use the same motion preset for the same type of interaction.",
                        isGood: true
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            // Anti-patterns
            SectionCard(title: "✗ Anti-patterns") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    BestPracticeItem(
                        icon: "xmark.circle.fill",
                        title: "Hard-coded animation values",
                        description: "Avoid using .animation(.easeInOut(duration: 0.15)) directly.",
                        isGood: false
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Divider()

                    BestPracticeItem(
                        icon: "xmark.circle.fill",
                        title: "Excessive animations",
                        description: "Not every element needs an animation.",
                        isGood: false
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Divider()

                    BestPracticeItem(
                        icon: "xmark.circle.fill",
                        title: "Inappropriate motion choice",
                        description: "Avoid using slow or slower for buttons – they will feel sluggish.",
                        isGood: false
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }

    // MARK: - Helper Views

    private func codeBlock(_ code: String) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Text(code)
                .typography(.bodySmall)
                .fontDesign(.monospaced)
                .padding(spacing.md)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(colorPalette.surfaceVariant)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    NavigationStack {
        MotionCatalogView()
            .theme(ThemeProvider())
    }
}
