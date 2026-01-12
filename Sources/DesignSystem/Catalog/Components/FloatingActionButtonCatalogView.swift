import SwiftUI

/// Catalog view for FAB component
struct FloatingActionButtonCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var tapCount = 0

    var body: some View {
        CatalogPageContainer(title: "FAB") {
            VStack(alignment: .leading, spacing: spacing.sm) {
                CatalogOverview(description: "Button representing the most important action on screen")

                if tapCount > 0 {
                    Text("Tap count: \(tapCount)")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.primary)
                        .padding(.horizontal, spacing.lg)
                }
            }

            SectionCard(title: "Sizes") {
                VStack(spacing: spacing.lg) {
                    HStack {
                        Text("Small (40pt)")
                            .typography(.bodyMedium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        FloatingActionButton(icon: "plus", size: .small) { tapCount += 1 }
                    }
                    HStack {
                        Text("Regular (56pt)")
                            .typography(.bodyMedium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        FloatingActionButton(icon: "plus", size: .regular) { tapCount += 1 }
                    }
                    HStack {
                        Text("Large (96pt)")
                            .typography(.bodyMedium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        FloatingActionButton(icon: "plus", size: .large) { tapCount += 1 }
                    }
                }
            }

            SectionCard(title: "Icons") {
                VariantShowcase(title: "SF Symbols", description: "Any icon can be used") {
                    HStack(spacing: spacing.lg) {
                        FloatingActionButton(icon: "plus") { tapCount += 1 }
                        FloatingActionButton(icon: "pencil") { tapCount += 1 }
                        FloatingActionButton(icon: "camera") { tapCount += 1 }
                        FloatingActionButton(icon: "trash") { tapCount += 1 }
                    }
                }
            }

            SectionCard(title: "Usage Examples") {
                CodeExample(code: """
                    FloatingActionButton(
                        icon: "plus",
                        size: .regular
                    ) {
                        // Action
                    }
                    """)
            }

            SectionCard(title: "Layout Example") {
                VariantShowcase(title: "Bottom Right Placement", description: "Typical usage pattern") {
                    ZStack(alignment: .bottomTrailing) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(colors.surfaceVariant.opacity(0.3))
                            .frame(height: 200)

                        FloatingActionButton(icon: "plus") { tapCount += 1 }
                            .padding(spacing.lg)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FloatingActionButtonCatalogView()
            .theme(ThemeProvider())
    }
}
