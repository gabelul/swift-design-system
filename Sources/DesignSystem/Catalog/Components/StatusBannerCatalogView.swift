import SwiftUI

struct StatusBannerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Inline status banners for alerts, notifications, and feedback messages.")

                SectionCard(title: "Levels") {
                    VStack(spacing: spacing.md) {
                        StatusBanner("New features available", level: .info)
                        StatusBanner("Changes saved", level: .success)
                        StatusBanner("Storage almost full", level: .warning)
                        StatusBanner("Connection lost", level: .error)
                    }
                }

                SectionCard(title: "With Action") {
                    StatusBanner(
                        "Update available",
                        level: .info,
                        actionLabel: "Install"
                    ) {}
                }

                SectionCard(title: "Dismissible") {
                    StatusBanner("Check your connection", level: .warning, isDismissible: true)
                }

                CodeExample(code: """
                StatusBanner("Saved", level: .success)
                
                StatusBanner(
                    "Offline",
                    level: .error,
                    icon: "wifi.slash",
                    actionLabel: "Retry"
                ) {
                    reconnect()
                }
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("StatusBanner")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { StatusBannerCatalogView().theme(ThemeProvider()) } }
