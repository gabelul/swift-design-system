import SwiftUI

<<<<<<< HEAD
/// Spacing catalog view
/// Visually displays all spacing values
=======
/// スペーシングカタログビュー
>>>>>>> upstream/main
struct SpacingCatalogView: View {
    @Environment(\.spacingScale) private var spacing
    @Environment(\.colorPalette) private var colors

    var body: some View {
<<<<<<< HEAD
        ScrollView {
            VStack(alignment: .leading, spacing: spacingScale.xl) {
                // Overview
                Text("T-shirt size–based spacing scale")
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

                // Usage
                SectionCard(title: "Usage") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How to use in SwiftUI")
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
=======
        CatalogPageContainer(title: "スペーシング") {
            CatalogOverview(description: "Tシャツサイズベースのスペーシングスケール")

            SectionCard(title: "Spacing Scale") {
                VStack(spacing: spacing.md) {
                    SpacingDemoView(name: "none", value: spacing.none)
                    SpacingDemoView(name: "xxs", value: spacing.xxs)
                    SpacingDemoView(name: "xs", value: spacing.xs)
                    SpacingDemoView(name: "sm", value: spacing.sm)
                    SpacingDemoView(name: "md", value: spacing.md)
                    SpacingDemoView(name: "lg", value: spacing.lg)
                    SpacingDemoView(name: "xl", value: spacing.xl)
                    SpacingDemoView(name: "xxl", value: spacing.xxl)
                    SpacingDemoView(name: "xxxl", value: spacing.xxxl)
                    SpacingDemoView(name: "xxxxl", value: spacing.xxxxl)
>>>>>>> upstream/main
                }
            }

            SectionCard(title: "使用例") {
                CodeExample(code: """
                    @Environment(\\.spacingScale) var spacing

                    VStack(spacing: spacing.md) {
                        Text("Hello")
                        Text("World")
                    }
                    .padding(spacing.lg)
                    """)
            }
        }
<<<<<<< HEAD
        .background(colorPalette.background)
        .navigationTitle("Spacing")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
=======
>>>>>>> upstream/main
    }
}

#Preview {
    NavigationStack {
        SpacingCatalogView()
            .environment(\.spacingScale, DefaultSpacingScale())
    }
}
