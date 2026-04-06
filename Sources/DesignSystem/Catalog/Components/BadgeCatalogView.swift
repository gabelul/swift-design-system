import SwiftUI

struct BadgeCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Notification dot or count badge. Use standalone or attach to any view with the .badge() modifier.")

                SectionCard(title: "Standalone") {
                    HStack(spacing: spacing.xl) {
                        VStack { Badge(); Text("Dot").typography(.labelSmall) }
                        VStack { Badge(count: 3); Text("Count").typography(.labelSmall) }
                        VStack { Badge(count: 150); Text("Overflow").typography(.labelSmall) }
                    }
                    .foregroundStyle(colors.onSurfaceVariant)
                }

                SectionCard(title: "As Modifier") {
                    HStack(spacing: spacing.xl) {
                        Image(systemName: "bell.fill").font(.title2).badge()
                        Image(systemName: "envelope.fill").font(.title2).badge(12)
                        Image(systemName: "cart.fill").font(.title2).badge(3)
                    }
                    .foregroundStyle(colors.onSurface)
                }

                CodeExample(code: """
                // Dot badge
                Image(systemName: "bell.fill").badge()
                
                // Count badge
                Image(systemName: "cart").badge(5)
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("Badge")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { BadgeCatalogView().theme(ThemeProvider()) } }
