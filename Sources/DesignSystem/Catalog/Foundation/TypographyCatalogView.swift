import SwiftUI

/// Typography catalog view
struct TypographyCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "Typography") {
            CatalogOverview(description: "15 typography tokens based on Material Design 3")

            SectionCard(title: "Display") {
                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .displayLarge, text: "Display Large")
                    TypographyDemoView(style: .displayMedium, text: "Display Medium")
                    TypographyDemoView(style: .displaySmall, text: "Display Small")
                }
            }

            SectionCard(title: "Headline") {
                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .headlineLarge, text: "Headline Large")
                    TypographyDemoView(style: .headlineMedium, text: "Headline Medium")
                    TypographyDemoView(style: .headlineSmall, text: "Headline Small")
                }
            }

            SectionCard(title: "Title") {
                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .titleLarge, text: "Title Large")
                    TypographyDemoView(style: .titleMedium, text: "Title Medium")
                    TypographyDemoView(style: .titleSmall, text: "Title Small")
                }
            }

            SectionCard(title: "Body") {
                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .bodyLarge, text: "Body Large - Standard body text")
                    TypographyDemoView(style: .bodyMedium, text: "Body Medium - Compact body")
                    TypographyDemoView(style: .bodySmall, text: "Body Small - Supplementary description")
                }
            }

            SectionCard(title: "Label") {
                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .labelLarge, text: "Label Large")
                    TypographyDemoView(style: .labelMedium, text: "Label Medium")
                    TypographyDemoView(style: .labelSmall, text: "Label Small")
                }
            }

            SectionCard(title: "Font Design") {
                VStack(spacing: spacing.lg) {
                    FontDesignDemoView(design: .default, name: "Default", sampleText: "Hello World 123")
                    FontDesignDemoView(design: .serif, name: "Serif", sampleText: "Hello World 123")
                    FontDesignDemoView(design: .rounded, name: "Rounded", sampleText: "Hello World 123")
                    FontDesignDemoView(design: .monospaced, name: "Monospaced", sampleText: "Hello World 123")
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    Text("Headline")
                        .typography(.headlineLarge)

                    Text("Body text")
                        .typography(.bodyMedium)

                    Text("Display in serif")
                        .typography(.bodyMedium, design: .serif)
                    """)
            }
        }
    }
}

// MARK: - Typography Demo View

private struct TypographyDemoView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    let style: Typography
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            Text(text)
                .typography(style)
                .foregroundStyle(colors.onSurface)

            HStack(spacing: spacing.md) {
                SpecLabel(label: "Size", value: "\(Int(style.size))pt")
                SpecLabel(label: "Weight", value: weightName(style.weight))
                SpecLabel(label: "Line Height", value: "\(Int(style.lineHeight))pt")
            }
            .opacity(0.7)
        }
        .padding(.vertical, spacing.sm)
    }

    private func weightName(_ weight: Font.Weight) -> String {
        switch weight {
        case .bold: return "Bold"
        case .semibold: return "Semibold"
        case .medium: return "Medium"
        case .regular: return "Regular"
        default: return "Regular"
        }
    }
}

private struct SpecLabel: View {
    @Environment(\.colorPalette) private var colors

    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 4) {
            Text(label)
                .typography(.labelSmall)
                .foregroundStyle(colors.onSurfaceVariant)
            Text(value)
                .typography(.labelSmall)
                .fontDesign(.monospaced)
                .foregroundStyle(colors.onSurfaceVariant)
        }
    }
}

private struct FontDesignDemoView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    let design: Font.Design
    let name: String
    let sampleText: String

    var body: some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            Text(name)
                .typography(.titleSmall)
                .foregroundStyle(colors.onSurface)

            Text(sampleText)
                .typography(.bodyLarge, design: design)
                .foregroundStyle(colors.onSurface)
        }
        .padding(.vertical, spacing.xs)
    }
}

#Preview {
    NavigationStack {
        TypographyCatalogView()
            .theme(ThemeProvider())
    }
}
