import SwiftUI

/// Catalog detail view
/// Last column of NavigationSplitView that shows details for the selected item
struct CatalogDetailView: View {
    let category: CatalogCategory?
    let foundationItem: FoundationItem?
    let componentItem: ComponentType?
    let patternItem: PatternItem?

    var body: some View {
        Group {
            if let category {
                switch category {
                case .themes:
                    ThemeGalleryView()
                case .foundations:
                    foundationDetailView
                case .components:
                    componentDetailView
                case .patterns:
                    patternDetailView
                }
            } else {
                emptyStateView
            }
        }
    }

    @ViewBuilder
    private var foundationDetailView: some View {
        if let item = foundationItem {
            switch item {
            case .colors:
                ColorsCatalogView()
                    .id(item)
            case .typography:
                TypographyCatalogView()
                    .id(item)
            case .spacing:
                SpacingCatalogView()
                    .id(item)
            case .radius:
                RadiusCatalogView()
                    .id(item)
            case .motion:
                MotionCatalogView()
                    .id(item)
            }
        } else {
            itemSelectionPrompt
        }
    }

    @ViewBuilder
    private var componentDetailView: some View {
        if let component = componentItem {
            switch component {
            case .button:
                ButtonCatalogView()
                    .id(component)
            case .card:
                CardCatalogView()
                    .id(component)
            case .chip:
                ChipCatalogView()
                    .id(component)
            case .colorPicker:
                ColorPickerCatalogView()
                    .id(component)
            case .emojiPicker:
                EmojiPickerCatalogView()
                    .id(component)
            case .fab:
                FloatingActionButtonCatalogView()
                    .id(component)
            case .iconButton:
                IconButtonCatalogView()
                    .id(component)
            case .iconPicker:
                IconPickerCatalogView()
                    .id(component)
            case .imagePicker:
                #if canImport(UIKit)
                ImagePickerCatalogView()
                    .id(component)
                #else
                ContentUnavailableView {
                    Label("iOS Only", systemImage: "iphone")
                } description: {
                    Text("The image picker is only available on iOS.")
                }
                #endif
            case .snackbar:
                SnackbarCatalogView()
                    .id(component)
            case .textField:
                TextFieldCatalogView()
                    .id(component)
            }
        } else {
            itemSelectionPrompt
        }
    }

    @ViewBuilder
    private var patternDetailView: some View {
        if let pattern = patternItem {
            switch pattern {
            case .aspectGrid:
                AspectGridCatalogView()
                    .id(pattern)
            case .sectionCard:
                SectionCardCatalogView()
                    .id(pattern)
            }
        } else {
            itemSelectionPrompt
        }
    }

    private var itemSelectionPrompt: some View {
        ZStack {
            Color.clear
            ContentUnavailableView {
                Label("Select an item", systemImage: "doc.text.fill")
            } description: {
                Text("Select an item from the content list.")
            }
        }
    }

    private var emptyStateView: some View {
        ZStack {
            Color.clear
            ContentUnavailableView {
                Label("Explore the catalog", systemImage: "book.fill")
            } description: {
                Text("Select a category in the sidebar to get started.")
            }
        }
    }
}

#Preview("Empty State") {
    CatalogDetailView(
        category: nil,
        foundationItem: nil,
        componentItem: nil,
        patternItem: nil
    )
    .theme(ThemeProvider())
}

#Preview("Theme Gallery") {
    CatalogDetailView(
        category: .themes,
        foundationItem: nil,
        componentItem: nil,
        patternItem: nil
    )
    .theme(ThemeProvider())
}

#Preview("Foundation Item") {
    CatalogDetailView(
        category: .foundations,
        foundationItem: .colors,
        componentItem: nil,
        patternItem: nil
    )
    .theme(ThemeProvider())
}
