import Foundation

/// コンポーネントの種類
enum ComponentType: String, CaseIterable, Identifiable {
    case button = "Button"
    case card = "Card"
    case fab = "FloatingActionButton"
    case iconButton = "IconButton"
    case textField = "TextField"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .button: return "hand.tap.fill"
        case .card: return "rectangle.fill"
        case .fab: return "plus.circle.fill"
        case .iconButton: return "heart.circle.fill"
        case .textField: return "textformat.abc"
        }
    }

    var description: String {
        switch self {
        case .button: return "Primary, Secondary, Tertiaryの3種類"
        case .card: return "関連情報をグループ化するコンテナ"
        case .fab: return "画面上の主要アクションボタン"
        case .iconButton: return "アイコンのみのコンパクトなボタン"
        case .textField: return "テキスト入力フィールド"
        }
    }
}
