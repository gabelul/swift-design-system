import SwiftUI

struct InsetCalloutCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Lightly tinted semantic callout blocks for contextual guidance inside pages and cards.")

                VStack(spacing: spacing.md) {
                    InsetCallout(tone: .info, systemImage: "lock.fill", title: "Private sync") {
                        Text("Only you can see this data, and it stays in your iCloud account.")
                            .typography(.bodySmall)
                    }

                    InsetCallout(tone: .success, systemImage: "checkmark.circle.fill", title: "All set") {
                        Text("You are ready to continue to the next step.")
                            .typography(.bodySmall)
                    }

                    InsetCallout(tone: .warning, systemImage: "exclamationmark.circle.fill", title: "Almost ready") {
                        Text("Add one more record to complete setup.")
                            .typography(.bodySmall)
                    }
                }

                CodeExample(code: """
                InsetCallout(
                    tone: .info,
                    systemImage: "lock.fill",
                    title: "Private sync"
                ) {
                    Text("Only you can see this data.")
                        .typography(.bodySmall)
                }
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("InsetCallout")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { InsetCalloutCatalogView().theme(ThemeProvider()) } }
