import SwiftUI

/// AspectGridパターンのカタログビュー
/// レイアウトパターンとしてのAspectGridの使い方を詳しく説明
struct AspectGridCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // 概要
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("AspectGridは、すべてのアイテムに統一されたアスペクト比を適用するグリッドレイアウトパターンです")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)

                    Text("写真ギャラリー、商品一覧、メディアライブラリなど、一貫したアスペクト比が求められるコンテンツの表示に最適です")
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                }
                .padding(.horizontal, spacing.lg)
                .padding(.top, spacing.lg)

                // 構成
                SectionCard(title: "構成") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        SpecItem(
                            label: "ベース",
                            value: "LazyVGrid",
                            description: "遅延読み込みによる効率的なレンダリング"
                        )

                        Divider()

                        SpecItem(
                            label: "アスペクト比制御",
                            value: ".aspectRatio() modifier",
                            description: "すべてのアイテムに統一された比率を適用"
                        )

                        Divider()

                        SpecItem(
                            label: "幅制御",
                            value: "GridItem.adaptive(minimum:maximum:)",
                            description: "画面サイズに応じた自動調整"
                        )

                        Divider()

                        SpecItem(
                            label: "間隔",
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
                                }
                            }
                        }

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
                            itemAspectRatio: 1,  // 正方形
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
                    }
                }
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("AspectGrid")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        AspectGridCatalogView()
            .theme(ThemeProvider())
    }
}
