import SwiftUI

struct IconTileCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Rounded-square semantic icon tiles for feature highlights, benefit rows, and readiness/status lists.")

                SectionCard(title: "Tones") {
                    HStack(spacing: spacing.md) {
                        IconTile(systemName: "checkmark", tone: .success)
                        IconTile(systemName: "lock.fill", tone: .info)
                        IconTile(systemName: "exclamationmark", tone: .warning)
                        IconTile(systemName: "xmark", tone: .error)
                    }
                }

                SectionCard(title: "Sizes") {
                    HStack(spacing: spacing.md) {
                        IconTile(systemName: "checkmark", tone: .success, size: .small)
                        IconTile(systemName: "checkmark", tone: .success, size: .medium)
                        IconTile(systemName: "checkmark", tone: .success, size: .large)
                    }
                }

                CodeExample(code: """
                IconTile(systemName: "checkmark", tone: .success)
                IconTile(systemName: "lock.fill", tone: .info, size: .medium)
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("IconTile")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { IconTileCatalogView().theme(ThemeProvider()) } }
