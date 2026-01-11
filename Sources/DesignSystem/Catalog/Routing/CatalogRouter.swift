import SwiftUI

/// Catalog routing logic
///
<<<<<<< HEAD
/// Returns the appropriate detail view from category and item
=======
/// カテゴリから適切な詳細ビューを返す
@MainActor
>>>>>>> upstream/main
enum CatalogRouter {
    @ViewBuilder
    static func destination(for category: CatalogCategory) -> some View {
        switch category {
        case .themes:
            destinationForTheme()
        case .foundations:
            destinationForFoundation()
        case .components:
            destinationForComponent()
        case .patterns:
            destinationForPattern()
        }
    }

    // MARK: - Private Helpers

    @ViewBuilder
    private static func destinationForTheme() -> some View {
        ThemeGalleryView()
    }

    @ViewBuilder
<<<<<<< HEAD
    private static func destinationForFoundation(item: CatalogItem) -> some View {
        // Convert to FoundationItem in a type-safe way
        if let foundationItem = FoundationItem.allCases.first(where: { $0.rawValue == item.name }) {
            switch foundationItem {
            case .colors:
                ColorsCatalogView()
            case .typography:
                TypographyCatalogView()
            case .spacing:
                SpacingCatalogView()
            case .radius:
                RadiusCatalogView()
            case .motion:
                MotionCatalogView()
            }
        } else {
            ContentUnavailableView("Item not found", systemImage: "exclamationmark.triangle")
        }
=======
    private static func destinationForFoundation() -> some View {
        FoundationCatalogView()
>>>>>>> upstream/main
    }

    @ViewBuilder
    private static func destinationForComponent() -> some View {
        ComponentsCatalogView()
    }

    @ViewBuilder
    private static func destinationForPattern() -> some View {
        PatternsCatalogView()
    }
}
