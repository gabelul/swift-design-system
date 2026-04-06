import SwiftUI

/// Detail view for the catalog
/// Displays details of selected items in the last column of NavigationSplitView
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
            case .accordion:
                AccordionCatalogView()
                    .id(component)
            case .avatar:
                AvatarCatalogView()
                    .id(component)
            case .badge:
                BadgeCatalogView()
                    .id(component)
            case .bottomSheet:
                BottomSheetCatalogView()
                    .id(component)
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
            case .iconBadge:
                IconBadgeCatalogView()
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
                    Text("Image picker is only available on iOS")
                }
                #endif
            case .progressBar:
                ProgressBarCatalogView()
                    .id(component)
            case .searchField:
                SearchFieldCatalogView()
                    .id(component)
            case .secureField:
                SecureFieldCatalogView()
                    .id(component)
            case .skeleton:
                SkeletonCatalogView()
                    .id(component)
            case .emptyState:
                EmptyStateCatalogView()
                    .id(component)
            case .errorState:
                ErrorStateCatalogView()
                    .id(component)
            case .loadingState:
                LoadingStateCatalogView()
                    .id(component)
            case .snackbar:
                SnackbarCatalogView()
                    .id(component)
            case .statDisplay:
                StatDisplayCatalogView()
                    .id(component)
            case .statusBanner:
                StatusBannerCatalogView()
                    .id(component)
            case .textField:
                TextFieldCatalogView()
                    .id(component)
            case .toast:
                ToastCatalogView()
                    .id(component)
            case .videoPicker:
                #if canImport(UIKit)
                VideoPickerCatalogView()
                    .id(component)
                #else
                ContentUnavailableView {
                    Label("iOS Only", systemImage: "iphone")
                } description: {
                    Text("Video picker is only available on iOS")
                }
                #endif
            case .videoPlayer:
                #if canImport(UIKit)
                VideoPlayerCatalogView()
                    .id(component)
                #else
                ContentUnavailableView {
                    Label("iOS Only", systemImage: "iphone")
                } description: {
                    Text("Video player is only available on iOS")
                }
                #endif
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
            case .flowLayout:
                FlowLayoutCatalogView()
                    .id(pattern)
            case .screen:
                ScreenCatalogView()
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
                Label("Select Item", systemImage: "doc.text.fill")
            } description: {
                Text("Please select an item from the content list")
            }
        }
    }

    private var emptyStateView: some View {
        ZStack {
            Color.clear
            ContentUnavailableView {
                Label("Explore Catalog", systemImage: "book.fill")
            } description: {
                Text("Select a category from the sidebar to get started")
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
