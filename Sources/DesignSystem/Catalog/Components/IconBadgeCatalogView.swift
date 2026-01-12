import SwiftUI

/// Catalog view for IconBadge component
struct IconBadgeCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "IconBadge") {
            CatalogOverview(description: "Badge displaying SF Symbol icon on circular background")

            SectionCard(title: "Sizes") {
                HStack(spacing: spacing.xl) {
                    VStack(spacing: spacing.sm) {
                        IconBadge(systemName: "star.fill", size: .small)
                        Text("Small").typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
                    }
                    VStack(spacing: spacing.sm) {
                        IconBadge(systemName: "star.fill", size: .medium)
                        Text("Medium").typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
                    }
                    VStack(spacing: spacing.sm) {
                        IconBadge(systemName: "star.fill", size: .large)
                        Text("Large").typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
                    }
                    VStack(spacing: spacing.sm) {
                        IconBadge(systemName: "star.fill", size: .extraLarge)
                        Text("XL").typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
                    }
                }
                .frame(maxWidth: .infinity)
            }

            SectionCard(title: "Theme Colors") {
                HStack(spacing: spacing.lg) {
                    VStack(spacing: spacing.xs) {
                        IconBadge(systemName: "bolt.fill")
                        Text("Primary").typography(.labelSmall)
                    }
                    VStack(spacing: spacing.xs) {
                        IconBadge(systemName: "dumbbell.fill", foregroundColor: colors.secondary, backgroundColor: colors.secondary.opacity(0.15))
                        Text("Secondary").typography(.labelSmall)
                    }
                    VStack(spacing: spacing.xs) {
                        IconBadge(systemName: "figure.run", foregroundColor: colors.tertiary, backgroundColor: colors.tertiary.opacity(0.15))
                        Text("Tertiary").typography(.labelSmall)
                    }
                    VStack(spacing: spacing.xs) {
                        IconBadge(systemName: "exclamationmark.triangle.fill", foregroundColor: colors.error, backgroundColor: colors.error.opacity(0.15))
                        Text("Error").typography(.labelSmall)
                    }
                }
                .foregroundStyle(colors.onSurfaceVariant)
            }

            SectionCard(title: "Custom Colors") {
                HStack(spacing: spacing.lg) {
                    IconBadge(systemName: "flame.fill", size: .large, foregroundColor: .orange, backgroundColor: .orange.opacity(0.15))
                    IconBadge(systemName: "heart.fill", size: .large, foregroundColor: .red, backgroundColor: .red.opacity(0.15))
                    IconBadge(systemName: "leaf.fill", size: .large, foregroundColor: .green, backgroundColor: .green.opacity(0.15))
                    IconBadge(systemName: "drop.fill", size: .large, foregroundColor: .blue, backgroundColor: .blue.opacity(0.15))
                }
            }

            SectionCard(title: "Icon Gallery") {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: spacing.lg) {
                    iconWithLabel("bell.fill", "Notifications")
                    iconWithLabel("gear", "Settings")
                    iconWithLabel("person.fill", "User")
                    iconWithLabel("chart.bar.fill", "Statistics")
                    iconWithLabel("calendar", "Calendar")
                    iconWithLabel("clock.fill", "Clock")
                }
            }

            SectionCard(title: "Usage Examples") {
                CodeExample(code: """
                    IconBadge(
                        systemName: "heart.fill",
                        size: .large,
                        foregroundColor: .red,
                        backgroundColor: .red.opacity(0.15)
                    )
                    """)
            }
        }
    }

    @ViewBuilder
    private func iconWithLabel(_ systemName: String, _ label: String) -> some View {
        VStack(spacing: spacing.xs) {
            IconBadge(systemName: systemName)
            Text(label).typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
        }
    }
}

#Preview {
    NavigationStack {
        IconBadgeCatalogView()
            .theme(ThemeProvider())
    }
}
