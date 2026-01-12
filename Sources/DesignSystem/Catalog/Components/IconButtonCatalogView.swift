import SwiftUI

/// Catalog view for IconButton component
struct IconButtonCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var tapCount = 0

    var body: some View {
        CatalogPageContainer(title: "IconButton") {
            VStack(alignment: .leading, spacing: spacing.sm) {
                CatalogOverview(description: "Compact action button composed only of icon")

                if tapCount > 0 {
                    Text("Taps: \(tapCount)")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.primary)
                        .padding(.horizontal, spacing.lg)
                }
            }

            SectionCard(title: "Styles") {
                VStack(spacing: spacing.lg) {
                    HStack {
                        Text("Standard").typography(.bodyMedium).frame(width: 100, alignment: .leading)
                        IconButton(icon: "heart", style: .standard) { tapCount += 1 }
                        Text("No background").typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
                    }
                    HStack {
                        Text("Filled").typography(.bodyMedium).frame(width: 100, alignment: .leading)
                        IconButton(icon: "heart.fill", style: .filled) { tapCount += 1 }
                        Text("Primary background").typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
                    }
                    HStack {
                        Text("Tonal").typography(.bodyMedium).frame(width: 100, alignment: .leading)
                        IconButton(icon: "heart.fill", style: .tonal) { tapCount += 1 }
                        Text("Tonal background").typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
                    }
                    HStack {
                        Text("Outlined").typography(.bodyMedium).frame(width: 100, alignment: .leading)
                        IconButton(icon: "heart", style: .outlined) { tapCount += 1 }
                        Text("Border only").typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
                    }
                }
            }

            SectionCard(title: "Sizes") {
                VStack(spacing: spacing.lg) {
                    HStack {
                        Text("Small (32pt)").typography(.bodyMedium).frame(maxWidth: .infinity, alignment: .leading)
                        IconButton(icon: "star.fill", style: .filled, size: .small) { tapCount += 1 }
                    }
                    HStack {
                        Text("Medium (40pt)").typography(.bodyMedium).frame(maxWidth: .infinity, alignment: .leading)
                        IconButton(icon: "star.fill", style: .filled, size: .medium) { tapCount += 1 }
                    }
                    HStack {
                        Text("Large (48pt)").typography(.bodyMedium).frame(maxWidth: .infinity, alignment: .leading)
                        IconButton(icon: "star.fill", style: .filled, size: .large) { tapCount += 1 }
                    }
                }
            }

            SectionCard(title: "Icon Examples") {
                HStack(spacing: spacing.lg) {
                    IconButton(icon: "heart", style: .tonal) { tapCount += 1 }
                    IconButton(icon: "star", style: .tonal) { tapCount += 1 }
                    IconButton(icon: "bookmark", style: .tonal) { tapCount += 1 }
                    IconButton(icon: "square.and.arrow.up", style: .tonal) { tapCount += 1 }
                    IconButton(icon: "ellipsis", style: .tonal) { tapCount += 1 }
                }
            }

            SectionCard(title: "Usage Examples") {
                CodeExample(code: """
                    IconButton(
                        icon: "heart",
                        style: .filled,
                        size: .medium
                    ) {
                        // Action
                    }
                    """)
            }

            SectionCard(title: "Practical Example") {
                VariantShowcase(title: "Toolbar") {
                    Card {
                        VStack(spacing: spacing.md) {
                            HStack {
                                Text("Article Title").typography(.titleMedium)
                                Spacer()
                            }
                            Text("Preview text of the article body.")
                                .typography(.bodySmall)
                                .foregroundStyle(colors.onSurfaceVariant)
                            HStack {
                                IconButton(icon: "heart", style: .tonal) { tapCount += 1 }
                                IconButton(icon: "bookmark", style: .tonal) {}
                                IconButton(icon: "square.and.arrow.up", style: .tonal) {}
                                Spacer()
                                IconButton(icon: "ellipsis", style: .tonal) {}
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        IconButtonCatalogView()
            .theme(ThemeProvider())
    }
}
