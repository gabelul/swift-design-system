import SwiftUI

struct StatusPillCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Compact semantic status pills for Ready / Warning / Error / Info treatments without overloading the brand-primary Chip style.")

                SectionCard(title: "Tones") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        StatusPill("Ready", tone: .success, systemImage: "checkmark.circle.fill")
                        StatusPill("Almost Ready", tone: .warning, systemImage: "exclamationmark.circle.fill")
                        StatusPill("Needs Attention", tone: .error, systemImage: "xmark.circle.fill")
                        StatusPill("Synced", tone: .info, systemImage: "checkmark.icloud.fill")
                    }
                }

                SectionCard(title: "Sizes") {
                    HStack(spacing: spacing.md) {
                        StatusPill("Small", tone: .info, size: .small)
                        StatusPill("Medium", tone: .success, size: .medium)
                    }
                }

                CodeExample(code: """
                StatusPill("Ready", tone: .success)

                StatusPill(
                    "Almost Ready",
                    tone: .warning,
                    systemImage: "exclamationmark.circle.fill"
                )
                """)

                BestPracticeItem(
                    icon: "checkmark.circle.fill",
                    title: "Use StatusPill for semantic state",
                    description: "Choose StatusPill when the UI needs success/warning/error/info tone. Keep Chip for tags, filters, and brand-primary labels.",
                    isGood: true
                )
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("StatusPill")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { StatusPillCatalogView().theme(ThemeProvider()) } }
