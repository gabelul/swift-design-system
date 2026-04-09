import SwiftUI

struct ToastCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.notify) private var notify

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Auto-dismissing notification that appears at the top. No action buttons — use Snackbar for actionable messages.")

                SectionCard(title: "Presenter API (Preferred)") {
                    VStack(spacing: spacing.sm) {
                        Button("Success Toast") {
                            notify?.toast("Changes saved", level: .success)
                        }
                            .buttonStyle(.primary)
                        Button("Error Toast") {
                            notify?.toast("Something went wrong", level: .error)
                        }
                            .buttonStyle(.secondary)
                        Button("Info Toast") {
                            notify?.toast("New update available", level: .info)
                        }
                            .buttonStyle(.tertiary)

                        Button("Deduplicate Example") {
                            notify?.toast("Saved", level: .success)
                            notify?.toast("Saved", level: .success)
                        }
                        .buttonStyle(.tertiary)
                    }
                }

                CodeExample(code: """
                @Environment(\\.notify) private var notify

                notify?.toast("Saved", level: .success)
                """)

                CodeExample(code: """
                // Legacy standalone usage
                @State var toastState = ToastState()
                
                // Show
                toastState.show(message: "Saved", level: .success)
                
                // In view body
                .overlay(alignment: .top) {
                    Toast(state: toastState)
                }
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("Toast")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        ToastCatalogView()
            .installNotifications()
            .theme(ThemeProvider())
    }
}
