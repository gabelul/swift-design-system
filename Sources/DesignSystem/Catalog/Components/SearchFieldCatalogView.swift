import SwiftUI

struct SearchFieldCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var query1 = ""
    @State private var query2 = "SwiftUI"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Styled search input with magnifying glass icon, clear button, and optional cancel button.")

                SectionCard(title: "Empty") {
                    SearchField(text: $query1, placeholder: "Search items...")
                }

                SectionCard(title: "With Text") {
                    SearchField(text: $query2)
                }

                CodeExample(code: """
                @State private var query = ""
                
                SearchField(text: $query, placeholder: "Search...")
                
                SearchField(
                    text: $query,
                    showsCancelButton: false,
                    onSubmit: { performSearch() }
                )
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("SearchField")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { SearchFieldCatalogView().theme(ThemeProvider()) } }
