import Foundation

/// Pattern category types
enum PatternType: String, CaseIterable, Identifiable {
    case layout = "Layout Patterns"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .layout: return "rectangle.3.group.fill"
        }
    }

    var description: String {
        switch self {
        case .layout: return "Reusable layout structures"
        }
    }
}
