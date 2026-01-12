import SwiftUI

/// Catalog view for SectionCard pattern
struct SectionCardCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "SectionCard") {
            CatalogOverview(description: "A layout pattern for creating titled sections")

            SectionCard(title: "Structure") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    SpecItem(
                        label: "Title",
                        value: "Typography.titleMedium"
                    )
                    Divider()
                    SpecItem(
                        label: "Content",
                        value: "Card component"
                    )
                    Divider()
                    SpecItem(
                        label: "Spacing",
                        value: "spacing.md (12pt)"
                    )
                    Divider()
                    SpecItem(
                        label: "Padding",
                        value: "spacing.lg (16pt)"
                    )
                }
            }

            SectionCard(title: "Basic Example") {
                SectionCard(title: "Sample Section") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        Text("Content goes here")
                            .typography(.bodyMedium)

                        Text("Automatically wrapped with Card component")
                            .typography(.bodySmall)
                            .foregroundStyle(colors.onSurfaceVariant)
                    }
                }
            }

            SectionCard(title: "Complex Content") {
                SectionCard(title: "Feature List") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        FeatureRow(icon: "checkmark.circle.fill", title: "Automatic padding management")
                        FeatureRow(icon: "checkmark.circle.fill", title: "Card component integration")
                        FeatureRow(icon: "checkmark.circle.fill", title: "Spacing tokens support")
                        FeatureRow(icon: "checkmark.circle.fill", title: "Hierarchical information structure")
                    }
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    SectionCard(title: "Section Name") {
                        VStack(alignment: .leading, spacing: spacing.md) {
                            Text("Content")
                            Text("Multiple elements can be placed")
                        }
                    }
                    """)
            }

            SectionCard(title: "Best Practices") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Group related information",
                        description: "In settings or detail screens, group related items by section",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Hierarchical information structure",
                        description: "Organize information progressively with multiple SectionCards",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "xmark.circle.fill",
                        title: "Avoid excessive nesting",
                        description: "Multiple levels of nesting in SectionCard reduces readability",
                        isGood: false
                    )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SectionCardCatalogView()
            .theme(ThemeProvider())
    }
}
