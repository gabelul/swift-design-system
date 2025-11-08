import SwiftUI

/// カタログのメインカテゴリ
enum CatalogCategory: String, CaseIterable, Identifiable {
    case foundations = "デザイントークン"
    case components = "コンポーネント"
    case patterns = "パターン"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .foundations: return "slider.horizontal.3"
        case .components: return "square.stack.3d.up.fill"
        case .patterns: return "square.grid.3x3.fill"
        }
    }

    var description: String {
        switch self {
        case .foundations: return "Color, Spacing, Radiusなどの基本トークン"
        case .components: return "Button, Card, TextFieldなどの再利用可能なUI"
        case .patterns: return "レイアウトパターンやデザインパターン"
        }
    }

    var items: [CatalogItem] {
        switch self {
        case .foundations:
            return [
                CatalogItem(name: "カラー", icon: "paintpalette.fill", description: "カラーパレットとセマンティックカラー"),
                CatalogItem(name: "スペーシング", icon: "arrow.left.and.right", description: "レイアウト用のスペーシングスケール"),
                CatalogItem(name: "角丸", icon: "square.fill", description: "コーナー半径のスケール")
            ]
        case .components:
            return [
                CatalogItem(name: "コンポーネント一覧", icon: "square.stack.3d.up.fill", description: "全コンポーネントのカタログ")
            ]
        case .patterns:
            return [
                CatalogItem(name: "パターン一覧", icon: "square.grid.3x3.fill", description: "レイアウトパターンなど")
            ]
        }
    }
}
