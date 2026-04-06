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
                        FeatureRow(icon: "scroll.fill", title: "ScrollView wrapper")
                        FeatureRow(icon: "ruler.fill", title: "Consistent horizontal and vertical padding")
                        FeatureRow(icon: "paintbrush.fill", title: "Theme background color")
                        FeatureRow(icon: "textformat", title: "Optional navigation title")
                    }
                }

                // Code examples
                CodeExample(code: """
                // With title
                Screen("Settings") {
                    VStack(spacing: spacing.lg) {
                        SectionCard("Account") { ... }
                        SectionCard("Preferences") { ... }
                    }
                }

                // Without title
                Screen {
                    Text("Content")
                }
                """)

                BestPracticeItem(
                    icon: "checkmark.circle.fill",
                    title: "Use Screen as the root of every page",
                    description: "Screen handles scroll, padding, and background so you don't repeat boilerplate across views.",
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
