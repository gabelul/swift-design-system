import SwiftUI

/// Spacing catalog view
/// Visually displays all spacing values
struct SpacingCatalogView: View {
    @Environment(\.spacingScale) private var spacingScale
    @Environment(\.colorPalette) private var colorPalette

    var body: some View {
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
                }
            }
            .padding(.bottom, spacingScale.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("Spacing")
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
