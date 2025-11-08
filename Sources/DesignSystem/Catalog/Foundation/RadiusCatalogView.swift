import SwiftUI

/// 角丸カタログビュー
/// 全角丸値をプレビュー表示
struct RadiusCatalogView: View {
    @Environment(\.radiusScale) private var radiusScale
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // 概要
                Text("角丸スケール（Material Design 3 ベース）")
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(.horizontal, spacing.lg)
                    .padding(.top, spacing.lg)

                // Radius Scale
                SectionCard(title: "Radius Scale") {
                    VStack(spacing: spacing.md) {
                        RadiusDemoView(name: "none", value: radiusScale.none)
                        RadiusDemoView(name: "xs", value: radiusScale.xs)
                        RadiusDemoView(name: "sm", value: radiusScale.sm)
                        RadiusDemoView(name: "md", value: radiusScale.md)
                        RadiusDemoView(name: "lg", value: radiusScale.lg)
                        RadiusDemoView(name: "xl", value: radiusScale.xl)
                        RadiusDemoView(name: "xxl", value: radiusScale.xxl)
                        RadiusDemoView(name: "full", value: radiusScale.full)
                    }
                }

                // 使用例
                SectionCard(title: "使用例") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SwiftUI での使用方法")
                            .typography(.titleSmall)

                        Text("""
                        @Environment(\\.radiusScale) var radius

                        RoundedRectangle(cornerRadius: radius.md)
                            .fill(.blue)
                            .frame(height: 100)
                        """)
                        .typography(.bodySmall)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(colorPalette.surfaceVariant.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("角丸")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        RadiusCatalogView()
            .environment(\.radiusScale, DefaultRadiusScale())
    }
}
