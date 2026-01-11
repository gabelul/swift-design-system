import SwiftUI

/// Entry point for the components catalog
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

                    Text("Components Catalog")
                        .typography(.headlineLarge)
                        .foregroundStyle(colors.onBackground)

                    Text("Reusable UI components")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, spacing.xl)

<<<<<<< HEAD
                // Component list
                VStack(alignment: .leading, spacing: 12) {
                    Text("Components")
=======
                // コンポーネントリスト
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("コンポーネント")
>>>>>>> upstream/main
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
<<<<<<< HEAD
        .background(colorPalette.background)
        .navigationTitle("Components")
=======
        .background(colors.background)
        .navigationTitle("コンポーネント")
>>>>>>> upstream/main
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
<<<<<<< HEAD
            case .imagePicker:
                #if canImport(UIKit)
                ImagePickerCatalogView()
                #else
                ContentUnavailableView {
                    Label("iOS Only", systemImage: "iphone")
                } description: {
                    Text("The image picker is only available on iOS.")
                }
                #endif
=======
        case .imagePicker:
            #if canImport(UIKit)
            ImagePickerCatalogView()
            #else
            ContentUnavailableView {
                Label("iOS Only", systemImage: "iphone")
            } description: {
                Text("画像ピッカーはiOSでのみ利用可能です")
            }
            #endif
        case .progressBar:
            ProgressBarCatalogView()
>>>>>>> upstream/main
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
                Text("動画ピッカーはiOSでのみ利用可能です")
            }
            #endif
        case .videoPlayer:
            #if canImport(UIKit)
            VideoPlayerCatalogView()
            #else
            ContentUnavailableView {
                Label("iOS Only", systemImage: "iphone")
            } description: {
                Text("動画プレイヤーはiOSでのみ利用可能です")
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
