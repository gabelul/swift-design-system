import SwiftUI

/// Catalog view for the Screen component
struct ScreenCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(
                    description: "A scrollable page wrapper that provides standard padding, theme background, and optional navigation title. Use as the root container for every screen."
                )

                // Preview
                SectionCard(title: "Features") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        FeatureRow(icon: "scroll.fill", title: "Optional outer ScrollView wrapper")
                        FeatureRow(icon: "ruler.fill", title: "Configurable page padding density")
                        FeatureRow(icon: "paintbrush.fill", title: "Theme background color")
                        FeatureRow(icon: "textformat", title: "Configurable navigation title display mode")
                    }
                }

                // Code examples
                CodeExample(code: """
                // Standard page
                Screen("Settings") {
                    VStack(spacing: spacing.lg) {
                        SectionCard("Account") { ... }
                        SectionCard("Preferences") { ... }
                    }
                }

                // Denser parity pass
                Screen("Welcome", padding: .compact, titleDisplayMode: .inline) {
                    content
                }

                // Custom scroll handling
                Screen("Editor", scrollBehavior: .fixed, padding: .none) {
                    customScrollBody
                }
                """)

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

#Preview {
    NavigationStack {
        ScreenCatalogView()
            .theme(ThemeProvider())
    }
}
