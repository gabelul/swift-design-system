import SwiftUI

/// Split view for the design system catalog
/// Displays all design system elements hierarchically in a 3-column layout optimized for iPad
public struct DesignSystemCatalogSplitView: View {
    @Environment(ThemeProvider.self) private var themeProvider

    // Column visibility
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    // Selection state
    @State private var selectedCategory: CatalogCategory? = .themes
    @State private var selectedFoundationItem: FoundationItem?
    @State private var selectedComponentItem: ComponentType?
    @State private var selectedPatternItem: PatternItem?

    public init() {}

    public var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // Sidebar: Category list
            CatalogSidebarView(selectedCategory: $selectedCategory)
        } content: {
            // Content: Item list for selected category
            CatalogContentView(
                category: selectedCategory,
                selectedFoundationItem: $selectedFoundationItem,
                selectedComponentItem: $selectedComponentItem,
                selectedPatternItem: $selectedPatternItem
            )
        } detail: {
            // Detail: Details of selected item
            CatalogDetailView(
                category: selectedCategory,
                foundationItem: selectedFoundationItem,
                componentItem: selectedComponentItem,
                patternItem: selectedPatternItem
            )
        }
        .navigationSplitViewStyle(.balanced)
        .onChange(of: selectedCategory) { _, newCategory in
            // Reset selection when category changes
            selectedFoundationItem = nil
            selectedComponentItem = nil
            selectedPatternItem = nil
        }
    }
}

#Preview {
    DesignSystemCatalogSplitView()
        .theme(ThemeProvider())
}

#Preview("With Custom Theme") {
    @Previewable @State var themeProvider = ThemeProvider(
        initialTheme: OceanTheme()
    )

    DesignSystemCatalogSplitView()
        .theme(themeProvider)
}
