import SwiftUI

/// Catalog view for SectionCard pattern
struct SectionCardCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "SectionCard") {
            CatalogOverview(description: "Rounded surface cards for settings, hubs, and dashboards. Two styles: Surface Section (new, recommended) and Titled Card (legacy).")

            SectionCard("Surface Section — new API", footer: "The recommended style. Small uppercase header, rounded surface, optional footer caption. Stack SectionRow inside, separate with SectionRowDivider.") {
                SectionRow {
                    Text("Morning reminder")
                    Spacer(minLength: 0)
                    Text("ON").foregroundStyle(colors.onSurfaceVariant)
                }
                SectionRowDivider()
                SectionRow {
                    Label("Email", systemImage: "envelope")
                    Spacer(minLength: 0)
                    Text("user@example.com").foregroundStyle(colors.onSurfaceVariant)
                }
                SectionRowDivider()
                SectionNavigationLabel("Advanced settings", systemImage: "gear")
            }

            SectionCard(title: "Surface Section — code") {
                CodeExample(code: """
                    SectionCard("Notifications", footer: "Manage in Settings") {
                        SectionRow {
                            Text("Morning reminder")
                            Spacer(minLength: 0)
                            Toggle("", isOn: $isOn).labelsHidden()
                        }
                        SectionRowDivider()
                        NavigationLink(destination: DetailView()) {
                            SectionNavigationLabel("Advanced", systemImage: "gear")
                        }
                    }
                    """)
            }

            SectionCard(title: "Section family") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    SpecItem(label: "SectionCard", value: "Outer surface + header/footer")
                    Divider()
                    SpecItem(label: "SectionRow", value: "Unified-padding row, full-width tap")
                    Divider()
                    SpecItem(label: "SectionRowDivider", value: "0.5pt hairline, outlineVariant")
                    Divider()
                    SpecItem(label: "SectionNavigationLabel", value: "NavigationLink label with chevron")
                }
            }

            SectionCard(title: "Titled Card — legacy API (structure)") {
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
