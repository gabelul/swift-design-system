import SwiftUI

/// Catalog view for the FlowLayout component
struct FlowLayoutCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    private let sampleTags = [
        "SwiftUI", "iOS", "Design System", "Tokens", "Theme",
        "Layout", "Components", "Typography", "Color", "Spacing",
        "Motion", "Accessibility", "Dark Mode",
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(
                    description: "A layout that arranges views horizontally and wraps to the next line when space runs out. Great for tags, chips, and filter lists."
                )

                // Basic usage
                SectionCard(title: "Basic Usage") {
                    FlowLayout(spacing: 8) {
                        ForEach(sampleTags, id: \.self) { tag in
                            Chip(tag)
                        }
                    }
                }

                // With different spacing
                SectionCard(title: "Spacing Variants") {
                    VStack(alignment: .leading, spacing: spacing.lg) {
                        Text("Compact (4pt)")
                            .typography(.labelMedium)
                            .foregroundStyle(colors.onSurfaceVariant)
                        FlowLayout(spacing: 4) {
                            ForEach(sampleTags.prefix(6), id: \.self) { tag in
                                Chip(tag)
                            }
                        }

                        Text("Default (8pt)")
                            .typography(.labelMedium)
                            .foregroundStyle(colors.onSurfaceVariant)
                        FlowLayout(spacing: 8) {
                            ForEach(sampleTags.prefix(6), id: \.self) { tag in
                                Chip(tag)
                            }
                        }

                        Text("Spacious (16pt)")
                            .typography(.labelMedium)
                            .foregroundStyle(colors.onSurfaceVariant)
                        FlowLayout(spacing: 16) {
                            ForEach(sampleTags.prefix(6), id: \.self) { tag in
                                Chip(tag)
                            }
                        }
                    }
                }

                // Code example
                CodeExample(code: """
                FlowLayout(spacing: 8) {
                    ForEach(tags, id: \\.self) { tag in
                        Chip(tag)
                    }
                }
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("FlowLayout")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        FlowLayoutCatalogView()
            .theme(ThemeProvider())
    }
}
