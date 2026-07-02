import SwiftUI

/// Catalog view for the EmptyState component
struct EmptyStateCatalogView: View {
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "EmptyState") {
            CatalogOverview(description: "Placeholder for empty lists, grids, or search results. Communicates both what is missing and how to make it appear.")

            SectionCard(title: "Variants") {
                VStack(alignment: .leading, spacing: spacing.lg) {
                    VariantShowcase(title: "With description") {
                        EmptyState(
                            systemImage: "link",
                            title: "No Sources Yet",
                            description: "Referenced URLs from web research sessions will appear here."
                        )
                    }

                    Divider()

                    VariantShowcase(title: "Title only") {
                        EmptyState(
                            systemImage: "photo.on.rectangle.angled",
                            title: "No Media"
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EmptyStateCatalogView()
            .theme(ThemeProvider())
    }
}
