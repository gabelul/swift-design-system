import SwiftUI

/// Catalog view for the SectionCard pattern
/// Explains how to use SectionCard as a layout pattern
struct SectionCardCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // Overview
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("SectionCard is a layout pattern for creating sections with a title.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)

                    Text("Based on Material Design 3 patterns, it groups information hierarchically.")
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                }
                .padding(.horizontal, spacing.lg)
                .padding(.top, spacing.lg)

                // Structure
                SectionCard(title: "Structure") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        SpecItem(
                            label: "タイトル",
                            value: "Typography.titleMedium",
                            description: "Section heading."
                        )

                        Divider()

                        SpecItem(
                            label: "コンテンツ",
                            value: "Cardコンポーネント",
                            description: "Wraps content inside a Card."
                        )

                        Divider()

                        SpecItem(
                            label: "スペーシング",
                            value: "spacing.md (12pt)",
                            description: "Spacing between title and content."
                        )

                        Divider()

                        SpecItem(
                            label: "パディング",
                            value: "spacing.lg (16pt)",
                            description: "Horizontal padding (automatic)."
                        )
                    }
                }

                // Basic usage
                SectionCard(title: "Basic Usage") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("Simple text content.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        // Demo
                        SectionCard(title: "Sample Section") {
                            VStack(alignment: .leading, spacing: spacing.sm) {
                                Text("Content goes here.")
                                    .typography(.bodyMedium)

                                Text("SectionCard automatically wraps content in a Card.")
                                    .typography(.bodySmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }
                        }
                    }
                }

                // Complex content example
                SectionCard(title: "Complex Content Example") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("Complex layouts like lists and grids are also supported.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        // Demo
                        SectionCard(title: "Feature List") {
                            VStack(alignment: .leading, spacing: spacing.sm) {
                                FeatureRow(icon: "checkmark.circle.fill", title: "Automatic padding management")
                                FeatureRow(icon: "checkmark.circle.fill", title: "Integrated with Card component")
                                FeatureRow(icon: "checkmark.circle.fill", title: "Uses spacing tokens")
                                FeatureRow(icon: "checkmark.circle.fill", title: "Supports hierarchical information structure")
                            }
                        }
                    }
                }

                // Code example
                SectionCard(title: "Code Example") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        Text("How to use in SwiftUI")
                            .typography(.titleSmall)

                        Text("""
                        SectionCard(title: "Section Name") {
                            VStack(alignment: .leading, spacing: spacing.md) {
                                Text("Content")
                                Text("You can place multiple elements here.")
                            }
                        }
                        """)
                        .typography(.bodySmall)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(colorPalette.surfaceVariant.opacity(0.5))
                        .cornerRadius(8)
                    }
                }

                // Design specs
                SectionCard(title: "Design Specs") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("スペーシング")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)

                            SpecItem(label: "Title–content spacing", value: "spacing.md (12pt)")
                            SpecItem(label: "Horizontal padding", value: "spacing.lg (16pt)")
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("エレベーション")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)

                            SpecItem(label: "Card elevation", value: "level1 (default)")
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("タイポグラフィ")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)

                            SpecItem(label: "Title", value: "Typography.titleMedium")
                        }
                    }
                }

                // Usage guide
                SectionCard(title: "Usage Guide") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Group related information",
                            description: "In settings or detail screens, group related items into sections.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Hierarchical structure",
                            description: "Use multiple SectionCards to structure information step by step and improve scanability.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Clear titles",
                            description: "Give each section a concise title that reflects its content.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "xmark.circle.fill",
                            title: "Avoid deep nesting",
                            description: "Too many nested SectionCards make content hard to read.",
                            isGood: false
                        )
                    }
                }
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("SectionCard")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        SectionCardCatalogView()
            .theme(ThemeProvider())
    }
}
