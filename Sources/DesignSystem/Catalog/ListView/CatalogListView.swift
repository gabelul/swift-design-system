import SwiftUI

/// Catalog list view
/// Vertical scroll list displayed on iPhone or iPad Split View
struct CatalogListView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: spacing.xxl) {
                    // Category section
                    ForEach(CatalogCategory.allCases) { category in
                        CategorySectionView(category: category)
                    }

                    // Info section
                    InfoSectionView()
                }
                .padding(.top, spacing.lg)
                .padding(.bottom, spacing.xl)
            }
            .background(colors.background)
            .navigationTitle("Design System Catalog")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.large)
            #endif
        }
    }
}

#Preview {
    CatalogListView()
        .theme(ThemeProvider())
}
