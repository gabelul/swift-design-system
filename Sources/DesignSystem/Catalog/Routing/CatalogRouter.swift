import SwiftUI

/// Catalog routing logic
///
/// Returns appropriate detail views for categories
@MainActor
enum CatalogRouter {
    @ViewBuilder
    static func destination(for category: CatalogCategory) -> some View {
        switch category {
        case .themes:
            ThemeGalleryView()
        case .foundations:
            FoundationCatalogView()
        case .components:
            ComponentsCatalogView()
        case .patterns:
            PatternsCatalogView()
        }
    }
}
