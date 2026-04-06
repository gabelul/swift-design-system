import SwiftUI

/// Entry point for component catalog
struct ComponentsCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(spacing: spacing.xl) {
                // Header
                VStack(spacing: spacing.sm) {
                    Image(systemName: "square.stack.3d.up.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(colors.primary)

                    Text("Component Catalog")
                        .typography(.headlineLarge)
                        .foregroundStyle(colors.onBackground)

                    Text("Reusable UI components")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, spacing.xl)

                // Component list
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("Components")
                        .typography(.titleMedium)
                        .foregroundStyle(colors.onSurface)
                        .padding(.horizontal, spacing.lg)

                    VStack(spacing: spacing.sm) {
                        ForEach(ComponentType.allCases) { component in
                            NavigationLink {
                                destinationView(for: component)
                            } label: {
                                CatalogItemRowContent(
                                    icon: component.icon,
                                    title: component.rawValue,
                                    description: component.description
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, spacing.lg)
                }
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colors.background)
        .navigationTitle("Components")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    @ViewBuilder
    private func destinationView(for component: ComponentType) -> some View {
        switch component {
        case .button:
            ButtonCatalogView()
        case .card:
            CardCatalogView()
        case .chip:
            ChipCatalogView()
        case .colorPicker:
            ColorPickerCatalogView()
        case .emojiPicker:
            EmojiPickerCatalogView()
        case .fab:
            FloatingActionButtonCatalogView()
        case .iconBadge:
            IconBadgeCatalogView()
        case .iconButton:
            IconButtonCatalogView()
        case .iconPicker:
            IconPickerCatalogView()
        case .imagePicker:
            #if canImport(UIKit)
            ImagePickerCatalogView()
            #else
            ContentUnavailableView {
                Label("iOS Only", systemImage: "iphone")
            } description: {
                Text("Image picker is only available on iOS")
            }
            #endif
        case .progressBar:
            ProgressBarCatalogView()
        case .snackbar:
            SnackbarCatalogView()
        case .statDisplay:
            StatDisplayCatalogView()
        case .textField:
            TextFieldCatalogView()
        case .videoPicker:
            #if canImport(UIKit)
            VideoPickerCatalogView()
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
            #else
            ContentUnavailableView {
                Label("iOS Only", systemImage: "iphone")
            } description: {
                Text("Video player is only available on iOS")
            }
            #endif
        }
    }
}

#Preview {
    NavigationStack {
        ComponentsCatalogView()
            .theme(ThemeProvider())
    }
}
