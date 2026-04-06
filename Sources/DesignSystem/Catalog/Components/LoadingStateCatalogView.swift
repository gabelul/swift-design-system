import SwiftUI

struct LoadingStateCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Centered loading spinner with optional message text.")

                SectionCard(title: "Without Message") {
                    LoadingState()
                }

                SectionCard(title: "With Message") {
                    LoadingState(message: "Loading your data...")
                }

                CodeExample(code: """
                LoadingState()
                LoadingState(message: "Please wait...")
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("LoadingState")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { LoadingStateCatalogView().theme(ThemeProvider()) } }
