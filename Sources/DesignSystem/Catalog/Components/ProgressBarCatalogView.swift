import SwiftUI

struct ProgressBarCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing
    @State private var animatedValue: Double = 0.0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("進捗状況を視覚的に表示するバーコンポーネント")
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(.horizontal, spacing.lg)

                SectionCard(title: "基本") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("シンプルな進捗バー。値は0.0〜1.0の範囲。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: 12) {
                            HStack {
                                Text("25%")
                                    .typography(.labelMedium)
                                    .frame(width: 40, alignment: .trailing)
                                ProgressBar(value: 0.25)
                            }

                            HStack {
                                Text("50%")
                                    .typography(.labelMedium)
                                    .frame(width: 40, alignment: .trailing)
                                ProgressBar(value: 0.5)
                            }

                            HStack {
                                Text("75%")
                                    .typography(.labelMedium)
                                    .frame(width: 40, alignment: .trailing)
                                ProgressBar(value: 0.75)
                            }

                            HStack {
                                Text("100%")
                                    .typography(.labelMedium)
                                    .frame(width: 40, alignment: .trailing)
                                ProgressBar(value: 1.0)
                            }
                        }
                    }
                }

                SectionCard(title: "グラデーション") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("LinearGradientで塗りつぶしを指定可能。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: 12) {
                            ProgressBar(
                                value: 0.7,
                                gradient: LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )

                            ProgressBar(
                                value: 0.6,
                                gradient: LinearGradient(
                                    colors: [.green, .mint],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )

                            ProgressBar(
                                value: 0.8,
                                gradient: LinearGradient(
                                    colors: [.orange, .red],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        }
                    }
                }

                SectionCard(title: "サイズバリエーション") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("heightパラメータで高さを調整。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("4pt (Slim)")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                ProgressBar(value: 0.6, height: 4)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("8pt (Default)")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                ProgressBar(value: 0.6, height: 8)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("16pt (Large)")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                ProgressBar(value: 0.6, height: 16)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("24pt (Extra Large)")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                ProgressBar(value: 0.6, height: 24)
                            }
                        }
                    }
                }

                SectionCard(title: "カスタムカラー") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("foregroundColorとbackgroundColorでカスタマイズ。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: 12) {
                            ProgressBar(
                                value: 0.5,
                                foregroundColor: colorPalette.secondary,
                                backgroundColor: colorPalette.secondary.opacity(0.2)
                            )

                            ProgressBar(
                                value: 0.5,
                                foregroundColor: colorPalette.tertiary,
                                backgroundColor: colorPalette.tertiary.opacity(0.2)
                            )

                            ProgressBar(
                                value: 0.5,
                                foregroundColor: colorPalette.error,
                                backgroundColor: colorPalette.error.opacity(0.2)
                            )
                        }
                    }
                }

                SectionCard(title: "アニメーション") {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("animated: true で値変化時に自動アニメーション。")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("デフォルト (0.3s easeInOut)")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                ProgressBar(
                                    value: animatedValue,
                                    height: 12,
                                    foregroundColor: colorPalette.primary,
                                    animated: true
                                )
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("スプリング (bounce: 0.3)")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                ProgressBar(
                                    value: animatedValue,
                                    height: 12,
                                    foregroundColor: colorPalette.secondary,
                                    animated: true,
                                    animation: .spring(duration: 0.5, bounce: 0.3)
                                )
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("スロー (1.0s)")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                                ProgressBar(
                                    value: animatedValue,
                                    gradient: LinearGradient(
                                        colors: [colorPalette.tertiary, colorPalette.primary],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    height: 12,
                                    animated: true,
                                    animation: .easeInOut(duration: 1.0)
                                )
                            }
                        }

                        Button("アニメーション実行") {
                            animatedValue = animatedValue < 0.5 ? 1.0 : 0.0
                        }
                        .buttonStyle(.primary)
                        .buttonSize(.medium)
                    }
                }

                SectionCard(title: "使用例") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SwiftUI での使用方法")
                            .typography(.titleSmall)

                        Text("""
                        // Basic
                        ProgressBar(value: 0.75)

                        // With gradient
                        ProgressBar(
                            value: 0.5,
                            gradient: LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            height: 12
                        )

                        // Animated
                        ProgressBar(
                            value: progress,
                            animated: true,
                            animation: .spring(duration: 0.5)
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
        .navigationTitle("ProgressBar")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        ProgressBarCatalogView()
            .theme(ThemeProvider())
    }
}
