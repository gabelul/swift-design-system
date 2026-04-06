import SwiftUI

/// StatDisplay component catalog view
struct StatDisplayCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "StatDisplay") {
            CatalogOverview(description: "Statistics display component for showing values and units")

            SectionCard(title: "Sizes") {
                VStack(alignment: .leading, spacing: spacing.lg) {
                    LabeledVariant(label: "Small") { StatDisplay(value: "42.5", unit: "kg", size: .small) }
                    LabeledVariant(label: "Medium") { StatDisplay(value: "42.5", unit: "kg", size: .medium) }
                    LabeledVariant(label: "Large") { StatDisplay(value: "42.5", unit: "kg", size: .large) }
                    LabeledVariant(label: "Extra Large") { StatDisplay(value: "42.5", unit: "kg", size: .extraLarge) }
                }
            }

            SectionCard(title: "Colors") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    StatDisplay(value: "5.43", unit: "kg", size: .large, valueColor: colors.primary)
                    StatDisplay(value: "1,234", unit: "kcal", size: .large, valueColor: colors.secondary)
                    StatDisplay(value: "8.5", unit: "km", size: .large, valueColor: colors.tertiary)
                }
            }

            SectionCard(title: "Without Unit") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    StatDisplay(value: "42", size: .medium)
                    StatDisplay(value: "1,234,567", size: .large)
                }
            }

            SectionCard(title: "Alignment") {
                VStack(spacing: spacing.md) {
                    LabeledVariant(label: "Leading") {
                        StatDisplay(value: "100", unit: "pts", alignment: .leading)
                            .padding(spacing.sm)
                            .background(colors.surfaceVariant.opacity(0.5))
                    }
                    LabeledVariant(label: "Center") {
                        StatDisplay(value: "100", unit: "pts", alignment: .center)
                            .frame(maxWidth: .infinity)
                            .padding(spacing.sm)
                            .background(colors.surfaceVariant.opacity(0.5))
                    }
                }
            }

            SectionCard(title: "Practical Example") {
                VariantShowcase(title: "Dashboard") {
                    HStack(spacing: spacing.xl) {
                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("Muscle Mass").typography(.labelMedium).foregroundStyle(colors.onSurfaceVariant)
                            StatDisplay(value: "5.43", unit: "kg", valueColor: colors.secondary)
                        }
                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("Calories Burned").typography(.labelMedium).foregroundStyle(colors.onSurfaceVariant)
                            StatDisplay(value: "1,234", unit: "kcal", valueColor: colors.tertiary)
                        }
                    }
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    StatDisplay(
                        value: "1,234",
                        unit: "steps",
                        size: .large,
                        valueColor: .purple
                    )
                    """)
            }
        }
    }
}

#Preview {
    NavigationStack {
        StatDisplayCatalogView()
            .theme(ThemeProvider())
    }
}
