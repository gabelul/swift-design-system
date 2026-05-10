import SwiftUI

/// Catalog view for the Screen component
struct ScreenCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(
                    description: "A scrollable page wrapper that provides standard padding, theme background, navigation title control, and density-aware defaults. Use as the root container for every screen."
                )

                SectionCard(title: "Features") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        FeatureRow(icon: "scroll.fill", title: "Optional outer ScrollView wrapper")
                        FeatureRow(icon: "ruler.fill", title: "Density-aware page padding")
                        FeatureRow(icon: "paintbrush.fill", title: "Theme background color")
                        FeatureRow(icon: "textformat", title: "Configurable navigation title display mode")
                    }
                }

                CodeExample(code: """
                // Standard page
                Screen("Settings") {
                    VStack(spacing: spacing.lg) {
                        SectionCard("Account") { ... }
                        SectionCard("Preferences") { ... }
                    }
                }

                // Brand-driven density
                Screen("Welcome", padding: .automatic, titleDisplayMode: .inline) {
                    content
                }

                // Explicit denser parity pass
                Screen("Dashboard", padding: .compact) {
                    content
                }

                // Custom scroll handling
                Screen("Editor", scrollBehavior: .fixed, padding: .none) {
                    customScrollBody
                }
                """)

                SectionCard(title: "Density guidance") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        FeatureRow(icon: "arrow.down.to.line.compact", title: "Compact → dashboards, feeds, comparison-heavy screens")
                        FeatureRow(icon: "rectangle.portrait", title: "Standard → most forms, settings, and detail flows")
                        FeatureRow(icon: "arrow.up.and.down.text.horizontal", title: "Spacious → onboarding, editorial, and hero-heavy screens")
                    }
                }

                SectionCard(title: "Compiled screen recipes") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("These examples live in compiled catalog code so AI-facing recipes stay honest.")
                            .typography(.bodySmall)
                            .foregroundStyle(colors.onSurfaceVariant)

                        NavigationLink("Content / Detail Recipe") {
                            ContentDetailRecipeExample()
                        }
                        .buttonStyle(.secondary)
                        .buttonSize(.small)

                        NavigationLink("Dashboard / Feed Recipe") {
                            DashboardFeedRecipeExample()
                        }
                        .buttonStyle(.secondary)
                        .buttonSize(.small)

                        NavigationLink("Form / Action Recipe") {
                            FormActionRecipeExample()
                        }
                        .buttonStyle(.secondary)
                        .buttonSize(.small)
                    }
                }

                BestPracticeItem(
                    icon: "checkmark.circle.fill",
                    title: "Use Screen as the root of every page",
                    description: "Screen handles scroll, padding, background, and title presentation so you can tune density without rewriting the page shell.",
                    isGood: true
                )
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("Screen")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

private struct ContentDetailRecipeExample: View {
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        Screen("Content Detail", padding: .automatic) {
            VStack(alignment: .leading, spacing: spacing.lg) {
                SectionCard(title: "Overview") {
                    Text("Use this recipe for settings, details, FAQs, and account-style screens that need grouped information.")
                        .typography(.bodyMedium)
                }

                SectionCard(title: "Checklist") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        SectionRow {
                            Text("Density follows the installed screenDensity")
                                .typography(.bodyMedium)
                        }
                        SectionRowDivider()
                        SectionRow {
                            Text("Inner rhythm stays on semantic spacing tokens")
                                .typography(.bodyMedium)
                        }
                    }
                }
            }
        }
    }
}

private struct DashboardFeedRecipeExample: View {
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        Screen("Dashboard", padding: .compact) {
            VStack(alignment: .leading, spacing: spacing.lg) {
                Text("Compact density keeps card-heavy home screens feeling mobile-native.")
                    .typography(.bodySmall)

                AspectGrid(minItemWidth: 140, maxItemWidth: 180, itemAspectRatio: 1.15) {
                    ForEach(0..<4, id: \.self) { index in
                        Card {
                            VStack(alignment: .leading, spacing: spacing.sm) {
                                Text("Card \(index + 1)")
                                    .typography(.titleMedium)
                                Text("Short supporting copy that respects the semantic type scale.")
                                    .typography(.bodySmall)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
        }
    }
}

private struct FormActionRecipeExample: View {
    @State private var name = ""
    @State private var details = ""
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        Screen("Form", scrollBehavior: .fixed, padding: .automatic, titleDisplayMode: .inline) {
            VStack(spacing: spacing.lg) {
                DSTextField("Name", text: $name, placeholder: "Example")
                DSTextField("Notes", text: $details, axis: .vertical)

                VStack(spacing: spacing.sm) {
                    Button("Save") {}
                        .buttonStyle(.primary)
                        .buttonSize(.large)

                    Button("Cancel") {}
                        .buttonStyle(.secondary)
                        .buttonSize(.large)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScreenCatalogView()
            .theme(ThemeProvider())
    }
}
