import SwiftUI

struct StatDisplayCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("数値と単位を表示する統計表示コンポーネント")
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(.horizontal, spacing.lg)

                SectionCard(title: "サイズバリエーション") {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("small, medium, large, extraLargeの4サイズ。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Small")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                StatDisplay(value: "42.5", unit: "kg", size: .small)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Medium (Default)")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                StatDisplay(value: "42.5", unit: "kg", size: .medium)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Large")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                StatDisplay(value: "42.5", unit: "kg", size: .large)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Extra Large")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                StatDisplay(value: "42.5", unit: "kg", size: .extraLarge)
                            }
                        }
                    }
                }

                SectionCard(title: "カラーバリエーション") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("valueColorとunitColorで色をカスタマイズ。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(alignment: .leading, spacing: 12) {
                            StatDisplay(
                                value: "5.43",
                                unit: "kg",
                                size: .large,
                                valueColor: colorPalette.primary
                            )

                            StatDisplay(
                                value: "1,234",
                                unit: "kcal",
                                size: .large,
                                valueColor: colorPalette.secondary
                            )

                            StatDisplay(
                                value: "8.5",
                                unit: "km",
                                size: .large,
                                valueColor: colorPalette.tertiary
                            )
                        }
                    }
                }

                SectionCard(title: "単位なし") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("unitパラメータは省略可能。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(alignment: .leading, spacing: 12) {
                            StatDisplay(value: "42", size: .medium)
                            StatDisplay(value: "1,234,567", size: .large)
                        }
                    }
                }

                SectionCard(title: "配置") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("alignmentで水平配置を制御。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Leading")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                StatDisplay(value: "100", unit: "pts", alignment: .leading)
                                    .padding(spacing.sm)
                                    .background(colorPalette.surfaceVariant.opacity(0.5))
                                    .cornerRadius(8)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Center")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                StatDisplay(value: "100", unit: "pts", alignment: .center)
                                    .frame(maxWidth: .infinity)
                                    .padding(spacing.sm)
                                    .background(colorPalette.surfaceVariant.opacity(0.5))
                                    .cornerRadius(8)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Trailing")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                StatDisplay(value: "100", unit: "pts", alignment: .trailing)
                                    .padding(spacing.sm)
                                    .background(colorPalette.surfaceVariant.opacity(0.5))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }

                SectionCard(title: "実用例") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("ダッシュボードやメトリクス表示での使用例。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        HStack(spacing: 24) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("筋肉量")
                                    .typography(.labelMedium)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                StatDisplay(
                                    value: "5.43",
                                    unit: "kg",
                                    valueColor: colorPalette.secondary
                                )
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("消費カロリー")
                                    .typography(.labelMedium)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                StatDisplay(
                                    value: "1,234",
                                    unit: "kcal",
                                    valueColor: colorPalette.tertiary
                                )
                            }
                        }
                    }
                }

                SectionCard(title: "使用例") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SwiftUI での使用方法")
                            .typography(.titleSmall)

                        Text("""
                        // Basic
                        StatDisplay(value: "42.5", unit: "kg")

                        // Custom size and color
                        StatDisplay(
                            value: "1,234",
                            unit: "steps",
                            size: .large,
                            valueColor: .purple
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
        .navigationTitle("StatDisplay")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        StatDisplayCatalogView()
            .theme(ThemeProvider())
    }
}
