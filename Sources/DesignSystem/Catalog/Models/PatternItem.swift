import Foundation

/// Pattern items
enum PatternItem: String, CaseIterable, Identifiable {
    case aspectGrid = "AspectGrid"
    case sectionCard = "SectionCard"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .aspectGrid: return "square.grid.2x2.fill"
        case .sectionCard: return "rectangle.fill.on.rectangle.fill"
        }
    }

    var description: String {
        switch self {
        case .aspectGrid: return "Grid layout with fixed aspect ratio."
        case .sectionCard: return "Section container with a title."
        }
    }
}
