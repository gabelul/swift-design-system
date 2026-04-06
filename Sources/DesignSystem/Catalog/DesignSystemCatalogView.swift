import SwiftUI

/// Entry point for the design system catalog
/// Hierarchically displays all elements of the design system
///
/// Automatically selects the optimal layout based on screen size:
/// - Regular horizontal size class: 3-column NavigationSplitView
/// - Compact horizontal size class: NavigationStack-based list display
///
/// This ensures proper support for iPad Split View and Slide Over.
public struct DesignSystemCatalogView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    public init() {}

    public var body: some View {
        if horizontalSizeClass == .regular {
            DesignSystemCatalogSplitView()
        } else {
            CatalogListView()
        }
    }
}

#Preview {
    DesignSystemCatalogView()
        .theme(ThemeProvider())
}
