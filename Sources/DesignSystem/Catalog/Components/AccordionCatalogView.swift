import SwiftUI

struct AccordionCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Expandable/collapsible section with animated toggle. Tap the header to reveal or hide content.")

                SectionCard(title: "Basic Usage") {
                    VStack(spacing: spacing.md) {
                        Accordion("Account Settings") {
                            VStack(alignment: .leading, spacing: spacing.sm) {
                                Text("Email: user@example.com").typography(.bodyMedium)
                                Text("Plan: Pro").typography(.bodyMedium)
                            }
                        }

                        Accordion("Notifications", isExpanded: true) {
                            VStack(alignment: .leading, spacing: spacing.sm) {
                                Text("Push: Enabled").typography(.bodyMedium)
                                Text("Email: Disabled").typography(.bodyMedium)
                            }
                        }
                    }
                }

                CodeExample(code: """
                Accordion("Section Title") {
                    Text("Collapsible content")
                }
                
                // Start expanded
                Accordion("Details", isExpanded: true) {
                    Text("Visible by default")
                }
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("Accordion")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { AccordionCatalogView().theme(ThemeProvider()) } }
