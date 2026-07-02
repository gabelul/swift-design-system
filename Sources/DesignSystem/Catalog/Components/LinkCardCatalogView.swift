import SwiftUI

/// Catalog view for the LinkCard component
struct LinkCardCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    private let sampleURL = URL(string: "https://docs.swift.org/swift-book/")!
    private let blogURL = URL(string: "https://swift.org/blog/")!

    var body: some View {
        CatalogPageContainer(title: "LinkCard") {
            CatalogOverview(description: "Represents a URL reference — a source, related link, or citation — as a single card. Fetching metadata is the caller's responsibility; this component only renders it.")

            SectionCard(title: "Variants") {
                VStack(alignment: .leading, spacing: spacing.lg) {
                    VariantShowcase(title: "Basic", description: "Title + domain. When an action is provided, a trailing chevron appears.") {
                        LinkCard(
                            title: "Swift Concurrency - The Swift Programming Language",
                            url: sampleURL,
                            action: {}
                        )
                    }

                    Divider()

                    VariantShowcase(title: "No title", description: "When title is nil, the hostname is used as the heading.") {
                        LinkCard(title: nil, url: blogURL, action: {})
                    }

                    Divider()

                    VariantShowcase(title: "With accessory", description: "Attach a Chip for signals like source verification status.") {
                        VStack(spacing: spacing.sm) {
                            LinkCard(title: "Verified Source", url: blogURL, action: {}) {
                                Chip("Fetched", systemImage: "checkmark")
                                    .chipStyle(.filled)
                                    .chipSize(.small)
                                    .foregroundColor(.green)
                            }
                            LinkCard(title: "Unverified Source", url: sampleURL, action: {}) {
                                Chip("Unverified", systemImage: "questionmark")
                                    .chipStyle(.filled)
                                    .chipSize(.small)
                                    .foregroundColor(.orange)
                            }
                        }
                    }

                    Divider()

                    VariantShowcase(title: "Static display", description: "No action (not tappable, no chevron)") {
                        LinkCard(title: "Reference-only link", url: sampleURL)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LinkCardCatalogView()
            .theme(ThemeProvider())
    }
}
