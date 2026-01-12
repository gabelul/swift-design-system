import SwiftUI

/// カタログのメインカテゴリ
enum CatalogCategory: String, CaseIterable, Identifiable {
    case themes = "テーマ"
    case foundations = "デザイントークン"
    case components = "コンポーネント"
    case patterns = "パターン"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .themes: return "paintpalette.fill"
        case .foundations: return "slider.horizontal.3"
        case .components: return "square.stack.3d.up.fill"
        case .patterns: return "square.grid.3x3.fill"
        }
    }

    var description: String {
        switch self {
        case .themes: return "アプリ全体のテーマを選択・カスタマイズ"
        case .foundations: return "Color, Spacing, Radiusなどの基本トークン"
        case .components: return "Button, Card, TextFieldなどの再利用可能なUI"
        case .patterns: return "レイアウトパターンやデザインパターン"
        }
    }

    var items: [CatalogItem] {
        switch self {
        case .themes:
            return [
                CatalogItem(name: "テーマギャラリー", icon: "paintpalette.fill", description: "全テーマを閲覧・切り替え")
            ]
        case .foundations:
            return [
                CatalogItem(name: "デザイントークン一覧", icon: "slider.horizontal.3", description: "Color, Typography, Spacingなど")
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
