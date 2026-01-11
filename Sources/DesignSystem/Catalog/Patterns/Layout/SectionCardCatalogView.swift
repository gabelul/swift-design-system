import SwiftUI

<<<<<<< HEAD
/// Catalog view for the SectionCard pattern
/// Explains how to use SectionCard as a layout pattern
=======
/// SectionCardパターンのカタログビュー
>>>>>>> upstream/main
struct SectionCardCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
<<<<<<< HEAD
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // Overview
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("SectionCard is a layout pattern for creating sections with a title.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)

                    Text("Based on Material Design 3 patterns, it groups information hierarchically.")
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
=======
        CatalogPageContainer(title: "SectionCard") {
            CatalogOverview(description: "タイトル付きのセクションを作成するレイアウトパターン")

            SectionCard(title: "構成") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    SpecItem(
                        label: "タイトル",
                        value: "Typography.titleMedium"
                    )
                    Divider()
                    SpecItem(
                        label: "コンテンツ",
                        value: "Cardコンポーネント"
                    )
                    Divider()
                    SpecItem(
                        label: "スペーシング",
                        value: "spacing.md (12pt)"
                    )
                    Divider()
                    SpecItem(
                        label: "パディング",
                        value: "spacing.lg (16pt)"
                    )
>>>>>>> upstream/main
                }
            }

<<<<<<< HEAD
                // Structure
                SectionCard(title: "Structure") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        SpecItem(
                            label: "Title",
                            value: "Typography.titleMedium",
                            description: "Section heading."
                        )

                        Divider()

                        SpecItem(
                            label: "Content",
                            value: "Card component",
                            description: "Wraps content inside a Card."
                        )

                        Divider()

                        SpecItem(
                            label: "Spacing",
                            value: "spacing.md (12pt)",
                            description: "Spacing between title and content."
                        )

                        Divider()

                        SpecItem(
                            label: "Padding",
                            value: "spacing.lg (16pt)",
                            description: "Horizontal padding (automatic)."
                        )
                    }
                }

                // Basic usage
                SectionCard(title: "Basic Usage") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("Simple text content.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        // Demo
                        SectionCard(title: "Sample Section") {
                            VStack(alignment: .leading, spacing: spacing.sm) {
                                Text("Content goes here.")
                                    .typography(.bodyMedium)

                                Text("SectionCard automatically wraps content in a Card.")
                                    .typography(.bodySmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }
                        }
                    }
                }

                // Complex content example
                SectionCard(title: "Complex Content Example") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("Complex layouts like lists and grids are also supported.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        // Demo
                        SectionCard(title: "Feature List") {
                            VStack(alignment: .leading, spacing: spacing.sm) {
                                FeatureRow(icon: "checkmark.circle.fill", title: "Automatic padding management")
                                FeatureRow(icon: "checkmark.circle.fill", title: "Integrated with Card component")
                                FeatureRow(icon: "checkmark.circle.fill", title: "Uses spacing tokens")
                                FeatureRow(icon: "checkmark.circle.fill", title: "Supports hierarchical information structure")
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
                        SectionCard(title: "Section Name") {
                            VStack(alignment: .leading, spacing: spacing.md) {
                                Text("Content")
                                Text("You can place multiple elements here.")
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
                            Text("Spacing")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)

                            SpecItem(label: "Title–content spacing", value: "spacing.md (12pt)")
                            SpecItem(label: "Horizontal padding", value: "spacing.lg (16pt)")
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("Elevation")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)

                            SpecItem(label: "Card elevation", value: "level1 (default)")
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: spacing.xs) {
                            Text("Typography")
                                .typography(.labelLarge)
                                .foregroundStyle(colorPalette.primary)

                            SpecItem(label: "Title", value: "Typography.titleMedium")
                        }
                    }
                }

                // Usage guide
                SectionCard(title: "Usage Guide") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Group related information",
                            description: "In settings or detail screens, group related items into sections.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Hierarchical structure",
                            description: "Use multiple SectionCards to structure information step by step and improve scanability.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Clear titles",
                            description: "Give each section a concise title that reflects its content.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "xmark.circle.fill",
                            title: "Avoid deep nesting",
                            description: "Too many nested SectionCards make content hard to read.",
                            isGood: false
                        )
=======
            SectionCard(title: "基本的な使用例") {
                SectionCard(title: "サンプルセクション") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        Text("ここにコンテンツが入ります")
                            .typography(.bodyMedium)

                        Text("自動的にCardコンポーネントでラップ")
                            .typography(.bodySmall)
                            .foregroundStyle(colors.onSurfaceVariant)
>>>>>>> upstream/main
                    }
                }
            }

            SectionCard(title: "複雑なコンテンツ") {
                SectionCard(title: "機能リスト") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        FeatureRow(icon: "checkmark.circle.fill", title: "自動パディング管理")
                        FeatureRow(icon: "checkmark.circle.fill", title: "Cardコンポーネント統合")
                        FeatureRow(icon: "checkmark.circle.fill", title: "Spacing tokens対応")
                        FeatureRow(icon: "checkmark.circle.fill", title: "階層的な情報構造")
                    }
                }
            }

            SectionCard(title: "使用例") {
                CodeExample(code: """
                    SectionCard(title: "セクション名") {
                        VStack(alignment: .leading, spacing: spacing.md) {
                            Text("コンテンツ")
                            Text("複数の要素を配置可能")
                        }
                    }
                    """)
            }

            SectionCard(title: "ベストプラクティス") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "関連情報のグループ化",
                        description: "設定画面や詳細画面で、関連項目をセクションごとにまとめる",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "階層的な情報構造",
                        description: "複数のSectionCardで情報を段階的に整理",
                        isGood: true
                    )
                    Divider()
                    BestPracticeItem(
                        icon: "xmark.circle.fill",
                        title: "過度なネストは避ける",
                        description: "SectionCard内に何重にもネストすると読みづらい",
                        isGood: false
                    )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SectionCardCatalogView()
            .theme(ThemeProvider())
    }
}
