import SwiftUI

/// Main categories for the catalog
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
        case .themes: return "Select and customize app-wide themes"
        case .foundations: return "Basic tokens like Color, Spacing, Radius"
        case .components: return "Reusable UI elements like Button, Card, TextField"
        case .patterns: return "Layout patterns and design patterns"
        }
    }

    var items: [CatalogItem] {
        switch self {
        case .themes:
            return [
                CatalogItem(name: "Theme Gallery", icon: "paintpalette.fill", description: "Browse and switch all themes")
            ]
        case .foundations:
            return [
                CatalogItem(name: "Design Token List", icon: "slider.horizontal.3", description: "Color, Typography, Spacing, etc.")
            ]
        case .components:
            return [
                CatalogItem(name: "Component List", icon: "square.stack.3d.up.fill", description: "Catalog of all components")
            ]
        case .patterns:
            return [
                CatalogItem(name: "Pattern List", icon: "square.grid.3x3.fill", description: "Layout patterns, etc.")
            ]
        }
    }
}
