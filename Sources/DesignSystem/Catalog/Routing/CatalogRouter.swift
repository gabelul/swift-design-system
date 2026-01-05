import SwiftUI

/// カタログのルーティングロジック
///
/// カテゴリとアイテムから適切な詳細ビューを返す
@MainActor
enum CatalogRouter {
    @ViewBuilder
    static func destination(for category: CatalogCategory, item: CatalogItem) -> some View {
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
    private static func destinationForFoundation() -> some View {
        FoundationCatalogView()
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
