import Foundation

/// Pattern items
enum PatternItem: String, CaseIterable, Identifiable {
    case aspectGrid = "AspectGrid"
    case flowLayout = "FlowLayout"
    case screen = "Screen"
    case sectionCard = "SectionCard"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .aspectGrid: return "square.grid.2x2.fill"
        case .flowLayout: return "rectangle.split.3x1.fill"
        case .screen: return "rectangle.portrait.fill"
        case .sectionCard: return "rectangle.fill.on.rectangle.fill"
        }
    }

    var description: String {
        switch self {
        case .aspectGrid: return "Fixed aspect ratio grid layout"
        case .flowLayout: return "Wrapping horizontal layout for tags and chips"
        case .screen: return "Scrollable page wrapper with standard padding"
        case .sectionCard: return "Section container with title"
        }
    }
}
