import SwiftUI

struct ToastCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var toastState = ToastState()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Auto-dismissing notification that appears at the top. No action buttons — use Snackbar for actionable messages.")

                SectionCard(title: "Try It") {
                    VStack(spacing: spacing.sm) {
                        Button("Success Toast") { toastState.show(message: "Changes saved", level: .success) }
                            .buttonStyle(.primary)
                        Button("Error Toast") { toastState.show(message: "Something went wrong", level: .error) }
                            .buttonStyle(.secondary)
                        Button("Info Toast") { toastState.show(message: "New update available", level: .info) }
                            .buttonStyle(.tertiary)
                    }
                }

                CodeExample(code: """
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
        .overlay(alignment: .top) { Toast(state: toastState) }
        .navigationTitle("Toast")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { ToastCatalogView().theme(ThemeProvider()) } }
