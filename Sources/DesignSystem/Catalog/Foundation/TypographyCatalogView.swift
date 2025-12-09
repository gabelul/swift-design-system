import SwiftUI

/// Typography catalog view
/// Visually displays the full type scale
struct TypographyCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // Overview
                overviewSection

                // Display
                displaySection

                // Headline
                headlineSection

                // Title
                titleSection

                // Body
                bodySection

                // Label
                labelSection

                // Font Design
                fontDesignSection

                // Usage examples
                usageSection
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("Typography")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    // MARK: - Overview

    @ViewBuilder
    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("Provides 15 predefined typography tokens.")
                .typography(.bodyMedium)
                .foregroundStyle(colorPalette.onSurfaceVariant)

            Text("Based on the Material Design 3 type scale, grouped into five categories: Display, Headline, Title, Body, and Label.")
                .typography(.bodySmall)
                .foregroundStyle(colorPalette.onSurfaceVariant)
        }
        .padding(.horizontal, spacing.lg)
        .padding(.top, spacing.lg)
    }

    // MARK: - Display Section

    @ViewBuilder
    private var displaySection: some View {
        SectionCard(title: "Display") {
            VStack(alignment: .leading, spacing: spacing.lg) {
                Text("Largest and most prominent text, used for hero sections and landing pages.")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .displayLarge, text: "Display Large")
                    TypographyDemoView(style: .displayMedium, text: "Display Medium")
                    TypographyDemoView(style: .displaySmall, text: "Display Small")
                }
            }
        }
    }

    // MARK: - Headline Section

    @ViewBuilder
    private var headlineSection: some View {
        SectionCard(title: "Headline") {
            VStack(alignment: .leading, spacing: spacing.lg) {
                Text("Used for section headings and important titles.")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .headlineLarge, text: "Headline Large")
                    TypographyDemoView(style: .headlineMedium, text: "Headline Medium")
                    TypographyDemoView(style: .headlineSmall, text: "Headline Small")
                }
            }
        }
    }

    // MARK: - Title Section

    @ViewBuilder
    private var titleSection: some View {
        SectionCard(title: "Title") {
            VStack(alignment: .leading, spacing: spacing.lg) {
                Text("Used for card titles, dialog titles, and list item headings.")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .titleLarge, text: "Title Large")
                    TypographyDemoView(style: .titleMedium, text: "Title Medium")
                    TypographyDemoView(style: .titleSmall, text: "Title Small")
                }
            }
        }
    }

    // MARK: - Body Section

    @ViewBuilder
    private var bodySection: some View {
        SectionCard(title: "Body") {
            VStack(alignment: .leading, spacing: spacing.lg) {
                Text("Used for body text, paragraphs, and descriptions. The most frequently used styles.")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .bodyLarge, text: "Body Large – Use for standard body text where readability is prioritized.")
                    TypographyDemoView(style: .bodyMedium, text: "Body Medium – Use for more compact body text and higher information density.")
                    TypographyDemoView(style: .bodySmall, text: "Body Small – Use for supplementary descriptions, notes, and small body text.")
                }
            }
        }
    }

    // MARK: - Label Section

    @ViewBuilder
    private var labelSection: some View {
        SectionCard(title: "Label") {
            VStack(alignment: .leading, spacing: spacing.lg) {
                Text("Used for text on UI components such as buttons, tabs, and form labels.")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                VStack(spacing: spacing.lg) {
                    TypographyDemoView(style: .labelLarge, text: "Label Large")
                    TypographyDemoView(style: .labelMedium, text: "Label Medium")
                    TypographyDemoView(style: .labelSmall, text: "Label Small")
                }
            }
        }
    }

    // MARK: - Font Design Section

    @ViewBuilder
    private var fontDesignSection: some View {
        SectionCard(title: "Font Design") {
            VStack(alignment: .leading, spacing: spacing.lg) {
                Text("Provides four font designs using the iOS/macOS system fonts.")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                VStack(spacing: spacing.lg) {
                    FontDesignDemoView(design: .default, name: "Default (Sans)", sampleText: "Hello World こんにちは世界 123")
                    FontDesignDemoView(design: .serif, name: "Serif", sampleText: "Hello World こんにちは世界 123")
                    FontDesignDemoView(design: .rounded, name: "Rounded", sampleText: "Hello World こんにちは世界 123")
                    FontDesignDemoView(design: .monospaced, name: "Monospaced", sampleText: "Hello World こんにちは世界 123")
                }
            }
        }
    }

    // MARK: - Usage Section

    @ViewBuilder
    private var usageSection: some View {
        SectionCard(title: "Usage") {
            VStack(alignment: .leading, spacing: spacing.md) {
                Text("How to use in SwiftUI")
                    .typography(.titleSmall)

                Text("""
                Text("Headline")
                    .typography(.headlineLarge)

                Text("Body text")
                    .typography(.bodyMedium)

                Text("Serif body")
                    .typography(.bodyMedium, design: .serif)

                Text("Label")
                    .typography(.labelSmall)
                """)
                .typography(.bodySmall)
                .fontDesign(.monospaced)
                .padding(spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(colorPalette.surfaceVariant)
                .cornerRadius(8)
            }
        }
    }
}

// MARK: - Typography Demo View

/// タイポグラフィスタイルのデモ表示コンポーネント
private struct TypographyDemoView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    let style: Typography
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            // サンプルテキスト
            Text(text)
                .typography(style)
                .foregroundStyle(colorPalette.onSurface)

            // スペック情報
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

/// スペックラベル表示コンポーネント
private struct SpecLabel: View {
    @Environment(\.colorPalette) private var colorPalette

    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 4) {
            Text(label)
                .typography(.labelSmall)
                .foregroundStyle(colorPalette.onSurfaceVariant)
            Text(value)
                .typography(.labelSmall)
                .fontDesign(.monospaced)
                .foregroundStyle(colorPalette.onSurfaceVariant)
        }
    }
}

/// フォントデザインのデモ表示コンポーネント
private struct FontDesignDemoView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    let design: Font.Design
    let name: String
    let sampleText: String

    var body: some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            // デザイン名
            Text(name)
                .typography(.titleSmall)
                .foregroundStyle(colorPalette.onSurface)

            // サンプルテキスト
            Text(sampleText)
                .typography(.bodyLarge, design: design)
                .foregroundStyle(colorPalette.onSurface)
                .padding(.vertical, spacing.xs)
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
