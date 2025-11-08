import SwiftUI

/// スペーシングカタログビュー
/// 全スペーシング値を視覚的に表示
struct SpacingCatalogView: View {
    @Environment(\.spacingScale) private var spacingScale
    @Environment(\.colorPalette) private var colorPalette

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacingScale.xl) {
                // 概要
                Text("Tシャツサイズベースのスペーシングスケール")
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(.horizontal, spacingScale.lg)
                    .padding(.top, spacingScale.lg)

                // Spacing Scale
                SectionCard(title: "Spacing Scale") {
                    VStack(spacing: spacingScale.md) {
                        SpacingDemoView(name: "none", value: spacingScale.none)
                        SpacingDemoView(name: "xxs", value: spacingScale.xxs)
                        SpacingDemoView(name: "xs", value: spacingScale.xs)
                        SpacingDemoView(name: "sm", value: spacingScale.sm)
                        SpacingDemoView(name: "md", value: spacingScale.md)
                        SpacingDemoView(name: "lg", value: spacingScale.lg)
                        SpacingDemoView(name: "xl", value: spacingScale.xl)
                        SpacingDemoView(name: "xxl", value: spacingScale.xxl)
                        SpacingDemoView(name: "xxxl", value: spacingScale.xxxl)
                        SpacingDemoView(name: "xxxxl", value: spacingScale.xxxxl)
                    }
                }

                // 使用例
                SectionCard(title: "使用例") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SwiftUI での使用方法")
                            .typography(.titleSmall)

                        Text("""
                        @Environment(\\.spacingScale) var spacing

                        VStack(spacing: spacing.md) {
                            Text("Hello")
                            Text("World")
                        }
                        .padding(spacing.lg)
                        """)
                        .typography(.bodySmall)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(colorPalette.surfaceVariant.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.bottom, spacingScale.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("スペーシング")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        SpacingCatalogView()
            .environment(\.spacingScale, DefaultSpacingScale())
    }
}
