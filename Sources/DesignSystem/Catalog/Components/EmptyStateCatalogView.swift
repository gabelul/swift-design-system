import SwiftUI

struct EmptyStateCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Placeholder for empty lists, search results, or content areas.")

                SectionCard(title: "Basic") {
                    EmptyState(icon: "tray", title: "No Items", message: "Your list is empty")
                }

                SectionCard(title: "With Action") {
                    EmptyState(icon: "magnifyingglass", title: "No Results", message: "Try different keywords") {
                        Button("Clear Search") {}
                            .buttonStyle(.secondary)
                    }
                }

                CodeExample(code: """
                EmptyState(icon: "tray", title: "No Items")
                
                EmptyState(icon: "heart", title: "No Favorites") {
                    Button("Browse") { }
                        .buttonStyle(.primary)
                }
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("EmptyState")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { EmptyStateCatalogView().theme(ThemeProvider()) } }
