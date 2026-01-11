import SwiftUI

<<<<<<< HEAD
/// AspectGrid pattern catalog view
/// Detailed explanation of how to use AspectGrid as a layout pattern
=======
/// AspectGridパターンのカタログビュー
>>>>>>> upstream/main
struct AspectGridCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    var body: some View {
<<<<<<< HEAD
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // Overview
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("AspectGrid is a grid layout pattern that applies a unified aspect ratio to all items")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)

                    Text("Ideal for displaying content that requires consistent aspect ratios, such as photo galleries, product listings, and media libraries")
=======
        CatalogPageContainer(title: "AspectGrid") {
            CatalogOverview(description: "統一されたアスペクト比を適用するグリッドレイアウトパターン")

            SectionCard(title: "1:1 - Square") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("商品サムネイル、プロフィール画像に最適")
>>>>>>> upstream/main
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)

<<<<<<< HEAD
                // Structure
                SectionCard(title: "Structure") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        SpecItem(
                            label: "Base",
                            value: "LazyVGrid",
                            description: "Efficient rendering through lazy loading"
                        )

                        Divider()

                        SpecItem(
                            label: "Aspect ratio control",
                            value: ".aspectRatio() modifier",
                            description: "Applies a unified ratio to all items"
                        )

                        Divider()

                        SpecItem(
                            label: "Width control",
                            value: "GridItem.adaptive(minimum:maximum:)",
                            description: "Automatic adjustment based on screen size"
                        )

                        Divider()

                        SpecItem(
                            label: "Spacing",
                            value: "GridSpacing token",
                            description: "xs, sm, md, lg, xl (8-24pt)"
                        )
                    }
                }

                // Basic usage
                SectionCard(title: "Basic Usage") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("Product grid (1:1 aspect ratio).")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        AspectGrid(
                            minItemWidth: 100,
                            maxItemWidth: 140,
                            itemAspectRatio: 1,
                            spacing: .md
                        ) {
                            ForEach(0..<6, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue.opacity(0.3))
                                    .overlay {
                                        Text("\(index + 1)")
                                            .typography(.bodyMedium)
                                            .foregroundStyle(.white)
                                    }
                            }
                        }
                    }
                }

                // Aspect ratio variations
                SectionCard(title: "Aspect Ratio Variations") {
                    VStack(alignment: .leading, spacing: spacing.lg) {
                        // 1:1 - Square
                        VStack(alignment: .leading, spacing: spacing.sm) {
                            Text("1:1 - Square")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)
                            Text("Best for product thumbnails, profile images, and icons.")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)

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
=======
                    AspectGrid(
                        minItemWidth: 80,
                        maxItemWidth: 100,
                        itemAspectRatio: 1,
                        spacing: .sm
                    ) {
                        ForEach(0..<6, id: \.self) { index in
                            RoundedRectangle(cornerRadius: radius.md)
                                .fill(colors.primary.opacity(0.3))
                                .overlay {
                                    Text("\(index + 1)")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colors.onPrimary)
>>>>>>> upstream/main
                                }
                        }
<<<<<<< HEAD

                        Divider()

                        // 3:4 - Photos
                        VStack(alignment: .leading, spacing: spacing.sm) {
                            Text("3:4 - Photos")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)
                            Text("Best for photos and portrait content.")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)

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

                        Divider()

                        // 16:9 - Videos
                        VStack(alignment: .leading, spacing: spacing.sm) {
                            Text("16:9 - Videos")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)
                            Text("Best for video thumbnails and wide content.")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)

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
                }

                // Spacing variations
                SectionCard(title: "Spacing Variations") {
                    VStack(alignment: .leading, spacing: spacing.lg) {
                        ForEach([
                            (GridSpacing.xs, "Extra Small (8pt)", "Dense layout."),
                            (GridSpacing.sm, "Small (12pt)", "Compact layout."),
                            (GridSpacing.md, "Medium (16pt)", "Standard layout (default)."),
                            (GridSpacing.lg, "Large (20pt)", "Spacious layout."),
                            (GridSpacing.xl, "Extra Large (24pt)", "Premium layout.")
                        ], id: \.0.rawValue) { item in
                            VStack(alignment: .leading, spacing: spacing.sm) {
                                Text(item.1)
                                    .typography(.labelLarge)
                                    .foregroundStyle(colorPalette.primary)
                                Text(item.2)
                                    .typography(.bodySmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)

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

                                if item.0 != .xl {
                                    Divider()
                                }
                            }
                        }
                    }
                }

                // Code example
                SectionCard(title: "Code Example") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        Text("How to use in SwiftUI")
                            .typography(.titleSmall)

                        Text("""
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
                        .typography(.bodySmall)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(colorPalette.surfaceVariant.opacity(0.5))
                        .cornerRadius(8)
                    }
                }

                // Design specs
                SectionCard(title: "Design Specs") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("Parameters")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)

                            SpecItem(label: "minItemWidth", value: "CGFloat", description: "Minimum item width (typically 80–160pt).")
                            SpecItem(label: "maxItemWidth", value: "CGFloat", description: "Maximum item width (typically 200–300pt).")
                            SpecItem(label: "itemAspectRatio", value: "CGFloat (required)", description: "Item aspect ratio (width / height).")
                            SpecItem(label: "spacing", value: "GridSpacing", description: "Default: .md (16pt).")
                            SpecItem(label: "alignment", value: "HorizontalAlignment", description: "Default: .center.")
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("Recommended aspect ratios")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)

                            SpecItem(label: "1:1 (1.0)", value: "Product thumbnails, profile images, icons.")
                            SpecItem(label: "3:4 (0.75)", value: "Photos, portrait content.")
                            SpecItem(label: "16:9 (1.78)", value: "Video thumbnails, wide content.")
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("Design guidelines")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)

                            SpecItem(label: "Material Design 3", value: "16–24dp gutters")
                            SpecItem(label: "Fluent 2", value: "8–16px gutters")
                            SpecItem(label: "Apple HIG", value: "8–20pt spacing")
                        }
                    }
                }

                // Usage guide
                SectionCard(title: "Usage Guide") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Use a unified aspect ratio",
                            description: "Applying the same aspect ratio to all items keeps grids clean and orderly.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Optimize for large screens",
                            description: "Set maxItemWidth to prevent items from becoming too large on iPad and other big screens.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Choose appropriate spacing",
                            description: "Select spacing (.xs to .xl) based on content density to improve readability.",
                            isGood: true
                        )
=======
>>>>>>> upstream/main
                    }
                }
            }

            SectionCard(title: "3:4 - Photos") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("写真、ポートレートに最適")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)

                    AspectGrid(
                        minItemWidth: 80,
                        maxItemWidth: 100,
                        itemAspectRatio: 3/4,
                        spacing: .sm
                    ) {
                        ForEach(0..<6, id: \.self) { index in
                            RoundedRectangle(cornerRadius: radius.md)
                                .fill(colors.secondary.opacity(0.3))
                                .overlay {
                                    Text("\(index + 1)")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colors.onSecondary)
                                }
                        }
                    }
                }
            }

            SectionCard(title: "16:9 - Videos") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("動画サムネイル、ワイドコンテンツに最適")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)

                    AspectGrid(
                        minItemWidth: 120,
                        maxItemWidth: 160,
                        itemAspectRatio: 16/9,
                        spacing: .md
                    ) {
                        ForEach(0..<4, id: \.self) { index in
                            RoundedRectangle(cornerRadius: radius.md)
                                .fill(colors.tertiary.opacity(0.3))
                                .overlay {
                                    Text("\(index + 1)")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colors.onTertiary)
                                }
                        }
                    }
                }
            }

            SectionCard(title: "間隔バリエーション") {
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
                                        .fill(colors.primary.opacity(0.3))
                                        .overlay {
                                            Text("\(index + 1)")
                                                .typography(.bodySmall)
                                                .foregroundStyle(colors.onPrimary)
                                        }
                                }
                            }
                        }
                    }
                }
            }

            SectionCard(title: "使用例") {
                CodeExample(code: """
                    AspectGrid(
                        minItemWidth: 140,
                        maxItemWidth: 180,
                        itemAspectRatio: 1,  // 正方形
                        spacing: .md
                    ) {
                        ForEach(products) { product in
                            ProductCardView(product)
                        }
                    }
                    """)
            }

            SectionCard(title: "ベストプラクティス") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "統一されたアスペクト比",
                        description: "すべてのアイテムに同じアスペクト比を適用",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "maxItemWidthを設定",
                        description: "大画面でアイテムが不自然に大きくなるのを防ぐ",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "適切な間隔の選択",
                        description: "コンテンツに応じてspacing(.xs〜.xl)を選択",
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
