import Foundation

/// パターンカテゴリの種類
enum PatternType: String, CaseIterable, Identifiable {
    case layout = "レイアウトパターン"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .layout: return "rectangle.3.group.fill"
        }
    }

    var description: String {
        switch self {
        case .layout: return "再利用可能なレイアウト構造"
        }
    }
}
