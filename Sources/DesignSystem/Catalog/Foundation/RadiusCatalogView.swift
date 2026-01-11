import SwiftUI

<<<<<<< HEAD
/// Corner radius catalog view
/// Previews all radius values
=======
/// 角丸カタログビュー
>>>>>>> upstream/main
struct RadiusCatalogView: View {
    @Environment(\.radiusScale) private var radius
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
<<<<<<< HEAD
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Overview
                Text("Corner radius scale (based on Material Design 3)")
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

                // Usage
                SectionCard(title: "Usage") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How to use in SwiftUI")
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
=======
        CatalogPageContainer(title: "角丸") {
            CatalogOverview(description: "Material Design 3ベースの角丸スケール")

            SectionCard(title: "Radius Scale") {
                VStack(spacing: spacing.md) {
                    RadiusDemoView(name: "none", value: radius.none)
                    RadiusDemoView(name: "xs", value: radius.xs)
                    RadiusDemoView(name: "sm", value: radius.sm)
                    RadiusDemoView(name: "md", value: radius.md)
                    RadiusDemoView(name: "lg", value: radius.lg)
                    RadiusDemoView(name: "xl", value: radius.xl)
                    RadiusDemoView(name: "xxl", value: radius.xxl)
                    RadiusDemoView(name: "full", value: radius.full)
>>>>>>> upstream/main
                }
            }

            SectionCard(title: "使用例") {
                CodeExample(code: """
                    @Environment(\\.radiusScale) var radius

                    RoundedRectangle(cornerRadius: radius.md)
                        .fill(.blue)
                        .frame(height: 100)
                    """)
            }
        }
<<<<<<< HEAD
        .background(colorPalette.background)
        .navigationTitle("Radius")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
=======
>>>>>>> upstream/main
    }
}

#Preview {
    NavigationStack {
        RadiusCatalogView()
            .environment(\.radiusScale, DefaultRadiusScale())
    }
}
