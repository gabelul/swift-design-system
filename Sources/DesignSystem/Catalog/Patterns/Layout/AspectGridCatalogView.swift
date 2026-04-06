import SwiftUI

/// Catalog view for AspectGrid pattern
struct AspectGridCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "AspectGrid") {
            CatalogOverview(description: "A grid layout pattern that applies a unified aspect ratio")

            SectionCard(title: "1:1 - Square") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("Ideal for product thumbnails, profile images")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)

                    AspectGrid(
                        minItemWidth: 80,
                        maxItemWidth: 100,
                        itemAspectRatio: 1,
                        spacing: .sm
                    ) {
                        ForEach(0..<6, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.blue.opacity(0.3))
                                .overlay {
                                    Text("\(index + 1)")
                                        .typography(.bodySmall)
                                        .foregroundStyle(.white)
                                }
                        }
                    }
                }
            }

            SectionCard(title: "3:4 - Photos") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("Ideal for photos, portraits")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)

                    AspectGrid(
                        minItemWidth: 80,
                        maxItemWidth: 100,
                        itemAspectRatio: 3/4,
                        spacing: .sm
                    ) {
                        ForEach(0..<6, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.purple.opacity(0.3))
                                .overlay {
                                    Text("\(index + 1)")
                                        .typography(.bodySmall)
                                        .foregroundStyle(.white)
                                }
                        }
                    }
                }
            }

            SectionCard(title: "16:9 - Videos") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("Ideal for video thumbnails, wide content")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)

                    AspectGrid(
                        minItemWidth: 120,
                        maxItemWidth: 160,
                        itemAspectRatio: 16/9,
                        spacing: .md
                    ) {
                        ForEach(0..<4, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.orange.opacity(0.3))
                                .overlay {
                                    Text("\(index + 1)")
                                        .typography(.bodySmall)
                                        .foregroundStyle(.white)
                                }
                        }
                    }
                }
            }

            SectionCard(title: "Spacing Variations") {
                VStack(alignment: .leading, spacing: spacing.lg) {
                    ForEach([
                        (GridSpacing.xs, "Extra Small (8pt)"),
                        (GridSpacing.md, "Medium (16pt)"),
                        (GridSpacing.xl, "Extra Large (24pt)")
                    ], id: \.0.rawValue) { item in
                        VStack(alignment: .leading, spacing: spacing.sm) {
                            Text(item.1)
                                .typography(.labelLarge)
                                .foregroundStyle(colors.primary)

                            AspectGrid(
                                minItemWidth: 60,
                                maxItemWidth: 80,
                                itemAspectRatio: 1,
                                spacing: item.0
                            ) {
                                ForEach(0..<6, id: \.self) { index in
                                    Circle()
                                        .fill(Color.blue.opacity(0.3))
                                        .overlay {
                                            Text("\(index + 1)")
                                                .typography(.bodySmall)
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                        }
                    }
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    AspectGrid(
                        minItemWidth: 140,
                        maxItemWidth: 180,
                        itemAspectRatio: 1,  // Square
                        spacing: .md
                    ) {
                        ForEach(products) { product in
                            ProductCardView(product)
                        }
                    }
                    """)
            }

            SectionCard(title: "Best Practices") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Unified aspect ratio",
                        description: "Apply the same aspect ratio to all items",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Set maxItemWidth",
                        description: "Prevents items from becoming unnaturally large on big screens",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Choose appropriate spacing",
                        description: "Select spacing (.xs to .xl) according to content",
                        isGood: true
                    )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AspectGridCatalogView()
            .theme(ThemeProvider())
    }
}
