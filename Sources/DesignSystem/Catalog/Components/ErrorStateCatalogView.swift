import SwiftUI

struct ErrorStateCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Full-screen error state with icon, message, and retry action.")

                SectionCard(title: "Default") {
                    ErrorState(onRetry: {})
                }

                SectionCard(title: "Custom") {
                    ErrorState(
                        title: "No Connection",
                        message: "Check your internet and try again",
                        icon: "wifi.slash",
                        onRetry: {}
                    )
                }

                CodeExample(code: """
                ErrorState(onRetry: { await reload() })
                
                ErrorState(
                    title: "Can't Load",
                    message: "Try again later",
                    icon: "wifi.slash",
                    onRetry: { }
                )
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("ErrorState")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { ErrorStateCatalogView().theme(ThemeProvider()) } }
