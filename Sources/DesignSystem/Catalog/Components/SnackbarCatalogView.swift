import SwiftUI

/// Snackbar component catalog view
struct SnackbarCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var snackbarState = SnackbarState()

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: spacing.xl) {
                    CatalogOverview(description: "Temporary notification UI displayed from the bottom of the screen")

                    SectionCard(title: "Basic") {
                        VariantShowcase(title: "Simple", description: "Message only") {
                            Button("Show") {
                                snackbarState.show(message: "Saved", duration: 3.0)
                            }
                            .buttonStyle(.primary)
                        }
                    }

                    SectionCard(title: "With Actions") {
                        VStack(alignment: .leading, spacing: spacing.md) {
                            VariantShowcase(title: "Single Action") {
                                Button("Show") {
                                    snackbarState.show(
                                        message: "Deleted",
                                        primaryAction: SnackbarAction(title: "Undo") {},
                                        duration: 5.0
                                    )
                                }
                                .buttonStyle(.primary)
                            }

                            Divider()

                            VariantShowcase(title: "Multiple Actions") {
                                Button("Show") {
                                    snackbarState.show(
                                        message: "Delete the file?",
                                        primaryAction: SnackbarAction(title: "Delete") {},
                                        secondaryAction: SnackbarAction(title: "Cancel") {},
                                        duration: 7.0
                                    )
                                }
                                .buttonStyle(.primary)
                            }
                        }
                    }

                    SectionCard(title: "Duration") {
                        HStack(spacing: spacing.md) {
                            Button("3 sec") {
                                snackbarState.show(message: "Disappears in 3 seconds", duration: 3.0)
                            }
                            .buttonStyle(.secondary)

                            Button("5 sec") {
                                snackbarState.show(message: "Disappears in 5 seconds", duration: 5.0)
                            }
                            .buttonStyle(.secondary)

                            Button("10 sec") {
                                snackbarState.show(message: "Disappears in 10 seconds", duration: 10.0)
                            }
                            .buttonStyle(.secondary)
                        }
                    }

                    SectionCard(title: "Best Practices") {
                        VStack(alignment: .leading, spacing: spacing.md) {
                            BestPracticeItem(icon: "checkmark.circle.fill", title: "Concise Messages", description: "Keep to 1-2 lines", isGood: true)
                            BestPracticeItem(icon: "checkmark.circle.fill", title: "Max 2 Actions", description: "Too many makes decision difficult", isGood: true)
                            BestPracticeItem(icon: "checkmark.circle.fill", title: "3-7 Second Duration", description: "Allow sufficient time for important actions", isGood: true)
                        }
                    }
                }
                .padding(.bottom, 100)
            }
            .background(colors.background)

            Snackbar(state: snackbarState)
        }
        .navigationTitle("Snackbar")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        SnackbarCatalogView()
            .theme(ThemeProvider())
    }
}
