import SwiftUI

/// Catalog view for card component
struct CardCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "Card") {
            CatalogOverview(description: "Versatile container for grouping related information")

            SectionCard(title: "Basic") {
                VariantShowcase(
                    title: "Default Settings",
                    description: "Elevation Level 1, 16pt padding"
                ) {
                    Card {
                        VStack(alignment: .leading, spacing: spacing.sm) {
                            Text("Card Title")
                                .typography(.titleMedium)
                            Text("Card body text")
                                .typography(.bodyMedium)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }

            SectionCard(title: "Elevation") {
                VariantShowcase(
                    title: "Depth Variations",
                    description: "Express visual hierarchy"
                ) {
                    VStack(spacing: spacing.md) {
                        ForEach([Elevation.level0, .level1, .level2, .level3, .level4, .level5], id: \.self) { elevation in
                            Card(elevation: elevation) {
                                HStack {
                                    Text("Level \(elevationNumber(elevation))")
                                        .typography(.bodyMedium)
                                    Spacer()
                                    Text("Elevation")
                                        .typography(.labelSmall)
                                        .foregroundStyle(colors.onSurfaceVariant)
                                }
                            }
                        }
                    }
                }
            }

            SectionCard(title: "Padding") {
                VariantShowcase(
                    title: "Padding Variations",
                    description: "Adjust based on content"
                ) {
                    VStack(spacing: spacing.md) {
                        Card(allSides: 8) {
                            Text("Compact (8pt)")
                                .typography(.bodySmall)
                        }
                        Card(allSides: 16) {
                            Text("Default (16pt)")
                                .typography(.bodyMedium)
                        }
                        Card(allSides: 24) {
                            Text("Comfortable (24pt)")
                                .typography(.bodyLarge)
                        }
                    }
                }
            }

            SectionCard(title: "Usage Examples") {
                CodeExample(code: """
                    Card(elevation: .level2) {
                        VStack(alignment: .leading) {
                            Text("Title")
                            Text("Body")
                        }
                    }
                    """)
            }
        }
    }

    private func elevationNumber(_ elevation: Elevation) -> Int {
        switch elevation {
        case .level0: return 0
        case .level1: return 1
        case .level2: return 2
        case .level3: return 3
        case .level4: return 4
        case .level5: return 5
        }
    }
}

#Preview {
    NavigationStack {
        CardCatalogView()
            .theme(ThemeProvider())
    }
}
