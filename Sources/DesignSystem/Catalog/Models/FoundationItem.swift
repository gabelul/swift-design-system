import Foundation

/// Design token (Foundation) items
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
        case .colors: return "Color palettes and semantic colors."
        case .typography: return "Font size and line-height scale."
        case .spacing: return "Spacing scale for layout."
        case .radius: return "Corner radius scale."
        case .motion: return "Animation timing and motion presets."
        }
    }
}
