import SwiftUI

struct IconBadgeCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("SF Symbolアイコンを円形背景で表示するバッジコンポーネント")
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(.horizontal, spacing.lg)

                SectionCard(title: "サイズバリエーション") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("small, medium, large, extraLargeの4サイズ。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        HStack(spacing: 20) {
                            VStack(spacing: 8) {
                                IconBadge(systemName: "star.fill", size: .small)
                                Text("Small")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }

                            VStack(spacing: 8) {
                                IconBadge(systemName: "star.fill", size: .medium)
                                Text("Medium")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }

                            VStack(spacing: 8) {
                                IconBadge(systemName: "star.fill", size: .large)
                                Text("Large")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }

                            VStack(spacing: 8) {
                                IconBadge(systemName: "star.fill", size: .extraLarge)
                                Text("XL")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }

                SectionCard(title: "カラーバリエーション") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("テーマカラーまたはカスタムカラーを使用可能。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                VStack(spacing: 4) {
                                    IconBadge(systemName: "bolt.fill")
                                    Text("Primary")
                                        .typography(.labelSmall)
                                }

                                VStack(spacing: 4) {
                                    IconBadge(
                                        systemName: "dumbbell.fill",
                                        foregroundColor: colorPalette.secondary,
                                        backgroundColor: colorPalette.secondary.opacity(0.15)
                                    )
                                    Text("Secondary")
                                        .typography(.labelSmall)
                                }

                                VStack(spacing: 4) {
                                    IconBadge(
                                        systemName: "figure.run",
                                        foregroundColor: colorPalette.tertiary,
                                        backgroundColor: colorPalette.tertiary.opacity(0.15)
                                    )
                                    Text("Tertiary")
                                        .typography(.labelSmall)
                                }

                                VStack(spacing: 4) {
                                    IconBadge(
                                        systemName: "exclamationmark.triangle.fill",
                                        foregroundColor: colorPalette.error,
                                        backgroundColor: colorPalette.error.opacity(0.15)
                                    )
                                    Text("Error")
                                        .typography(.labelSmall)
                                }
                            }
                            .foregroundStyle(colorPalette.onSurfaceVariant)
                        }
                    }
                }

                SectionCard(title: "カスタムカラー") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("任意の色の組み合わせが可能。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        HStack(spacing: 16) {
                            IconBadge(
                                systemName: "flame.fill",
                                size: .large,
                                foregroundColor: .orange,
                                backgroundColor: .orange.opacity(0.15)
                            )
                            IconBadge(
                                systemName: "heart.fill",
                                size: .large,
                                foregroundColor: .red,
                                backgroundColor: .red.opacity(0.15)
                            )
                            IconBadge(
                                systemName: "leaf.fill",
                                size: .large,
                                foregroundColor: .green,
                                backgroundColor: .green.opacity(0.15)
                            )
                            IconBadge(
                                systemName: "drop.fill",
                                size: .large,
                                foregroundColor: .blue,
                                backgroundColor: .blue.opacity(0.15)
                            )
                        }
                    }
                }

                SectionCard(title: "アイコンギャラリー") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("様々なSF Symbolが使用可能。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 16) {
                            iconWithLabel("bell.fill", "通知")
                            iconWithLabel("gear", "設定")
                            iconWithLabel("person.fill", "ユーザー")
                            iconWithLabel("chart.bar.fill", "統計")
                            iconWithLabel("calendar", "カレンダー")
                            iconWithLabel("clock.fill", "時計")
                        }
                    }
                }

                SectionCard(title: "使用例") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SwiftUI での使用方法")
                            .typography(.titleSmall)

                        Text("""
                        // Basic
                        IconBadge(systemName: "star.fill")

                        // Custom size and colors
                        IconBadge(
                            systemName: "heart.fill",
                            size: .large,
                            foregroundColor: .red,
                            backgroundColor: .red.opacity(0.15)
                        )
                        """)
                        .typography(.bodySmall)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(colorPalette.surfaceVariant)
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("IconBadge")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    @ViewBuilder
    private func iconWithLabel(_ systemName: String, _ label: String) -> some View {
        VStack(spacing: 4) {
            IconBadge(systemName: systemName)
            Text(label)
                .typography(.labelSmall)
                .foregroundStyle(colorPalette.onSurfaceVariant)
        }
    }
}

#Preview {
    NavigationStack {
        IconBadgeCatalogView()
            .theme(ThemeProvider())
    }
}
