import Foundation

/// Items for Design Tokens (Foundation)
enum FoundationItem: String, CaseIterable, Identifiable {
    case colors = "Colors"
    case typography = "Typography"
    case spacing = "Spacing"
    case radius = "Radius"
    case motion = "Motion"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .colors: return "paintpalette.fill"
        case .typography: return "textformat.size"
        case .spacing: return "arrow.left.and.right"
        case .radius: return "square.fill"
        case .motion: return "waveform.path"
        }
    }

    var description: String {
        switch self {
        case .colors: return "Color palettes and semantic colors"
        case .typography: return "Font size and line height scales"
        case .spacing: return "Spacing scale for layouts"
        case .radius: return "Corner radius scale"
        case .motion: return "Animation timing and motion"
        }
    }
}
