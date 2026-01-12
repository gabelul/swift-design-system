import SwiftUI

/// Main catalog categories
enum CatalogCategory: String, CaseIterable, Identifiable {
    case themes = "Themes"
    case foundations = "Design Tokens"
    case components = "Components"
    case patterns = "Patterns"

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
<<<<<<< HEAD
        case .themes: return "Select and customize app-wide themes."
        case .foundations: return "Core tokens such as Color, Spacing, and Radius."
        case .components: return "Reusable UI elements such as Button, Card, and TextField."
        case .patterns: return "Layout and design patterns."
        }
    }

    var items: [CatalogItem] {
        switch self {
        case .themes:
            return [
                CatalogItem(name: "Theme Gallery", icon: "paintpalette.fill", description: "Browse and switch between all themes.")
            ]
        case .foundations:
            return [
                CatalogItem(name: "Colors", icon: "paintpalette.fill", description: "Color palettes and semantic colors."),
                CatalogItem(name: "Typography", icon: "textformat.size", description: "Font size and line-height scale."),
                CatalogItem(name: "Spacing", icon: "arrow.left.and.right", description: "Spacing scale for layout."),
                CatalogItem(name: "Radius", icon: "square.fill", description: "Corner radius scale."),
                CatalogItem(name: "Motion", icon: "waveform.path", description: "Animation timing and motion presets.")
            ]
        case .components:
            return [
                CatalogItem(name: "Components List", icon: "square.stack.3d.up.fill", description: "Catalog of all components.")
            ]
        case .patterns:
            return [
                CatalogItem(name: "Patterns List", icon: "square.grid.3x3.fill", description: "Layout and other patterns.")
            ]
=======
        case .themes: return "Browse and switch themes"
        case .foundations: return "Colors, Typography, Spacing, and more"
        case .components: return "All component catalogs"
        case .patterns: return "Layout patterns and more"
>>>>>>> upstream/main
        }
    }
}
