import SwiftUI

/// Radius catalog view
struct RadiusCatalogView: View {
    @Environment(\.radiusScale) private var radius
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "Radius") {
            CatalogOverview(description: "Corner radius scale based on Material Design 3")

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
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    @Environment(\\.radiusScale) var radius

                    RoundedRectangle(cornerRadius: radius.md)
                        .fill(.blue)
                        .frame(height: 100)
                    """)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RadiusCatalogView()
            .environment(\.radiusScale, DefaultRadiusScale())
    }
}
