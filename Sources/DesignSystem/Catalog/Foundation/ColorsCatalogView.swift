import SwiftUI

<<<<<<< HEAD
/// Color catalog view
/// Shows the current theme and provides collapsible color references
=======
/// カラーカタログビュー
>>>>>>> upstream/main
struct ColorsCatalogView: View {
    @Environment(ThemeProvider.self) private var themeProvider
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
<<<<<<< HEAD
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // Current theme
                currentThemeSection

                // References
                referenceSection
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("Colors")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
=======
        CatalogPageContainer(title: "カラー") {
            CatalogOverview(description: "現在のテーマ: \(themeProvider.themeMode == .light ? "ライト" : "ダーク")")

            SectionCard(title: "セマンティックカラー") {
                semanticColorsGrid(palette: colors)
            }
>>>>>>> upstream/main

            SectionCard(title: "リファレンス") {
                VStack(spacing: spacing.md) {
                    DisclosureGroup {
                        semanticColorsGrid(palette: LightColorPalette())
                            .padding(.top, spacing.sm)
                    } label: {
                        Text("デフォルトライトテーマ")
                            .typography(.bodyLarge)
                    }

<<<<<<< HEAD
    @ViewBuilder
    private var currentThemeSection: some View {
        VStack(alignment: .leading, spacing: spacing.lg) {
            VStack(alignment: .leading, spacing: spacing.sm) {
                Text("Currently applied theme")
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                Text("Mode: \(themeProvider.themeMode == .light ? "Light" : "Dark")")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant.opacity(0.7))
=======
                    DisclosureGroup {
                        semanticColorsGrid(palette: DarkColorPalette())
                            .padding(.top, spacing.sm)
                    } label: {
                        Text("デフォルトダークテーマ")
                            .typography(.bodyLarge)
                    }

                    DisclosureGroup {
                        primitiveColorsContent
                            .padding(.top, spacing.sm)
                    } label: {
                        Text("プリミティブカラー")
                            .typography(.bodyLarge)
                    }
                }
>>>>>>> upstream/main
            }
        }
    }

<<<<<<< HEAD
    // MARK: - Reference Section

    @ViewBuilder
    private var referenceSection: some View {
        VStack(alignment: .leading, spacing: spacing.lg) {
            Text("Reference")
                .typography(.titleMedium)
                .foregroundStyle(colorPalette.onSurface)
                .padding(.horizontal, spacing.lg)

            VStack(spacing: spacing.md) {
                DisclosureGroup {
                    semanticColorsGrid(palette: LightColorPalette())
                        .padding(.top, spacing.sm)
                } label: {
                    Text("Default Light Theme")
                        .typography(.bodyLarge)
                }
                .padding(spacing.lg)
                .background(colorPalette.surface)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                DisclosureGroup {
                    semanticColorsGrid(palette: DarkColorPalette())
                        .padding(.top, spacing.sm)
                } label: {
                    Text("Default Dark Theme")
                        .typography(.bodyLarge)
                }
                .padding(spacing.lg)
                .background(colorPalette.surface)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                DisclosureGroup {
                    primitiveColorsContent
                        .padding(.top, spacing.sm)
                } label: {
                    Text("Primitive Colors")
                        .typography(.bodyLarge)
                }
                .padding(spacing.lg)
                .background(colorPalette.surface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, spacing.lg)
        }
    }

    // MARK: - Semantic Colors

=======
>>>>>>> upstream/main
    @ViewBuilder
    private func semanticColorsGrid(palette: any ColorPalette) -> some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: spacing.sm) {
            ColorSwatchView(name: "primary", color: palette.primary)
            ColorSwatchView(name: "onPrimary", color: palette.onPrimary)
            ColorSwatchView(name: "primaryContainer", color: palette.primaryContainer)
            ColorSwatchView(name: "onPrimaryContainer", color: palette.onPrimaryContainer)
            ColorSwatchView(name: "secondary", color: palette.secondary)
            ColorSwatchView(name: "onSecondary", color: palette.onSecondary)
            ColorSwatchView(name: "secondaryContainer", color: palette.secondaryContainer)
            ColorSwatchView(name: "onSecondaryContainer", color: palette.onSecondaryContainer)
            ColorSwatchView(name: "tertiary", color: palette.tertiary)
            ColorSwatchView(name: "onTertiary", color: palette.onTertiary)
            ColorSwatchView(name: "error", color: palette.error)
            ColorSwatchView(name: "onError", color: palette.onError)
            ColorSwatchView(name: "errorContainer", color: palette.errorContainer)
            ColorSwatchView(name: "onErrorContainer", color: palette.onErrorContainer)
            ColorSwatchView(name: "background", color: palette.background)
            ColorSwatchView(name: "onBackground", color: palette.onBackground)
            ColorSwatchView(name: "surface", color: palette.surface)
            ColorSwatchView(name: "onSurface", color: palette.onSurface)
            ColorSwatchView(name: "surfaceVariant", color: palette.surfaceVariant)
            ColorSwatchView(name: "onSurfaceVariant", color: palette.onSurfaceVariant)
            ColorSwatchView(name: "outline", color: palette.outline)
        }
    }

    @ViewBuilder
    private var primitiveColorsContent: some View {
        VStack(alignment: .leading, spacing: spacing.lg) {
            Text("Base color palette for reference (Tailwind CSS based)")
                .typography(.bodySmall)
                .foregroundStyle(colors.onSurfaceVariant)

            VStack(alignment: .leading, spacing: spacing.sm) {
                Text("Blue").typography(.labelLarge)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: spacing.sm) {
                    ColorSwatchView(name: "blue50", color: PrimitiveColors.blue50, hexCode: "#EFF6FF")
                    ColorSwatchView(name: "blue100", color: PrimitiveColors.blue100, hexCode: "#DBEAFE")
                    ColorSwatchView(name: "blue200", color: PrimitiveColors.blue200, hexCode: "#BFDBFE")
                    ColorSwatchView(name: "blue300", color: PrimitiveColors.blue300, hexCode: "#93C5FD")
                    ColorSwatchView(name: "blue400", color: PrimitiveColors.blue400, hexCode: "#60A5FA")
                    ColorSwatchView(name: "blue500", color: PrimitiveColors.blue500, hexCode: "#3B82F6")
                    ColorSwatchView(name: "blue600", color: PrimitiveColors.blue600, hexCode: "#2563EB")
                    ColorSwatchView(name: "blue700", color: PrimitiveColors.blue700, hexCode: "#1D4ED8")
                    ColorSwatchView(name: "blue800", color: PrimitiveColors.blue800, hexCode: "#1E40AF")
                    ColorSwatchView(name: "blue900", color: PrimitiveColors.blue900, hexCode: "#1E3A8A")
                    ColorSwatchView(name: "blue950", color: PrimitiveColors.blue950, hexCode: "#172554")
                }
            }

            VStack(alignment: .leading, spacing: spacing.sm) {
                Text("Gray").typography(.labelLarge)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: spacing.sm) {
                    ColorSwatchView(name: "gray50", color: PrimitiveColors.gray50, hexCode: "#F9FAFB")
                    ColorSwatchView(name: "gray100", color: PrimitiveColors.gray100, hexCode: "#F3F4F6")
                    ColorSwatchView(name: "gray200", color: PrimitiveColors.gray200, hexCode: "#E5E7EB")
                    ColorSwatchView(name: "gray300", color: PrimitiveColors.gray300, hexCode: "#D1D5DB")
                    ColorSwatchView(name: "gray400", color: PrimitiveColors.gray400, hexCode: "#9CA3AF")
                    ColorSwatchView(name: "gray500", color: PrimitiveColors.gray500, hexCode: "#6B7280")
                    ColorSwatchView(name: "gray600", color: PrimitiveColors.gray600, hexCode: "#4B5563")
                    ColorSwatchView(name: "gray700", color: PrimitiveColors.gray700, hexCode: "#374151")
                    ColorSwatchView(name: "gray800", color: PrimitiveColors.gray800, hexCode: "#1F2937")
                    ColorSwatchView(name: "gray900", color: PrimitiveColors.gray900, hexCode: "#111827")
                    ColorSwatchView(name: "gray950", color: PrimitiveColors.gray950, hexCode: "#030712")
                }
            }

            HStack(spacing: spacing.lg) {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("Red").typography(.labelLarge)
                    VStack(spacing: spacing.sm) {
                        ColorSwatchView(name: "red500", color: PrimitiveColors.red500, hexCode: "#EF4444")
                        ColorSwatchView(name: "red600", color: PrimitiveColors.red600, hexCode: "#DC2626")
                    }
                }

                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("Green").typography(.labelLarge)
                    VStack(spacing: spacing.sm) {
                        ColorSwatchView(name: "green500", color: PrimitiveColors.green500, hexCode: "#10B981")
                        ColorSwatchView(name: "green600", color: PrimitiveColors.green600, hexCode: "#059669")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ColorsCatalogView()
            .theme(ThemeProvider())
    }
}
