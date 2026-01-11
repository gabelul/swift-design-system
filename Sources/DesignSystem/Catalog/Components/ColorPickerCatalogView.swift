import SwiftUI

/// ColorPicker catalog view
struct ColorPickerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var selectedColor1: String?
    @State private var selectedColor2: String?
    @State private var showColorPicker1 = false
    @State private var showColorPicker2 = false

    var body: some View {
<<<<<<< HEAD
        ScrollView {
            VStack(spacing: spacing.xl) {
                // Header
                headerSection

                // Basic usage
                basicUsageSection

                // Preset variations
                presetVariationsSection

                // Code example
                codeExampleSection
            }
            .padding(spacing.lg)
        }
        .background(colorPalette.background)
        .navigationTitle("ColorPicker")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private var headerSection: some View {
        VStack(spacing: spacing.md) {
            Image(systemName: "paintpalette.fill")
                .font(.system(size: 48))
                .foregroundStyle(colorPalette.primary)

            Text("ColorPicker")
                .typography(.headlineLarge)
                .foregroundStyle(colorPalette.onBackground)

            Text("Select a color from a preset palette.")
                .typography(.bodyMedium)
                .foregroundStyle(colorPalette.onSurfaceVariant)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private var basicUsageSection: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("Basic usage")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)

            Text("Color set suitable for tags and categories (tagFriendly).")
                .typography(.bodySmall)
                .foregroundStyle(colorPalette.onSurfaceVariant)

            VStack(spacing: spacing.md) {
                // 選択された色のプレビュー
                HStack(spacing: spacing.md) {
                    if let hex = selectedColor1 {
                        Circle()
                            .fill(Color(hex: hex))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(colorPalette.outline.opacity(0.2), lineWidth: 1)
                            )

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Selected color")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)
                            Text(hex)
                                .typography(.bodyMedium)
                                .foregroundStyle(colorPalette.onSurface)
                                .fontDesign(.monospaced)
                        }
                    } else {
                        Text("Select a color.")
                            .typography(.bodyMedium)
                            .foregroundStyle(colorPalette.onSurfaceVariant)
=======
        CatalogPageContainer(title: "ColorPicker") {
            CatalogOverview(description: "プリセットカラーから色を選択")

            SectionCard(title: "tagFriendly") {
                VStack(spacing: spacing.md) {
                    colorPreview(selectedColor: selectedColor1)

                    Button(selectedColor1 == nil ? "色を選択" : "色を変更") {
                        showColorPicker1 = true
>>>>>>> upstream/main
                    }
                    .buttonStyle(.primary)
                    .buttonSize(.medium)
                    .colorPicker(
                        preset: .tagFriendly,
                        selectedColor: $selectedColor1,
                        isPresented: $showColorPicker1
                    )
                }
<<<<<<< HEAD
                .padding(spacing.md)
                .background(colorPalette.surfaceVariant.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // Select button
                Button(selectedColor1 == nil ? "Select Color" : "Change Color") {
                    showColorPicker1 = true
                }
                .buttonStyle(.primary)
                .buttonSize(.medium)
                .colorPicker(
                    preset: .tagFriendly,
                    selectedColor: $selectedColor1,
                    isPresented: $showColorPicker1
                )
=======
>>>>>>> upstream/main
            }

<<<<<<< HEAD
    private var presetVariationsSection: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("Preset variations")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)

            Text("All primitive colors (allPrimitives).")
                .typography(.bodySmall)
                .foregroundStyle(colorPalette.onSurfaceVariant)

            VStack(spacing: spacing.md) {
                // 選択された色のプレビュー
                HStack(spacing: spacing.md) {
                    if let hex = selectedColor2 {
                        Circle()
                            .fill(Color(hex: hex))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(colorPalette.outline.opacity(0.2), lineWidth: 1)
                            )

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Selected color")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)
                            Text(hex)
                                .typography(.bodyMedium)
                                .foregroundStyle(colorPalette.onSurface)
                                .fontDesign(.monospaced)
                        }
                    } else {
                        Text("Select a color.")
                            .typography(.bodyMedium)
                            .foregroundStyle(colorPalette.onSurfaceVariant)
=======
            SectionCard(title: "allPrimitives") {
                VStack(spacing: spacing.md) {
                    colorPreview(selectedColor: selectedColor2)

                    Button(selectedColor2 == nil ? "色を選択" : "色を変更") {
                        showColorPicker2 = true
>>>>>>> upstream/main
                    }
                    .buttonStyle(.secondary)
                    .buttonSize(.medium)
                    .colorPicker(
                        preset: .allPrimitives,
                        selectedColor: $selectedColor2,
                        isPresented: $showColorPicker2
                    )
                }
<<<<<<< HEAD
                .padding(spacing.md)
                .background(colorPalette.surfaceVariant.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // Select button
                Button(selectedColor2 == nil ? "Select Color" : "Change Color") {
                    showColorPicker2 = true
                }
                .buttonStyle(.secondary)
                .buttonSize(.medium)
                .colorPicker(
                    preset: .allPrimitives,
                    selectedColor: $selectedColor2,
                    isPresented: $showColorPicker2
                )
=======
>>>>>>> upstream/main
            }

<<<<<<< HEAD
    private var codeExampleSection: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("Code example")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)

            VStack(alignment: .leading, spacing: spacing.sm) {
                codeBlock("""
=======
            SectionCard(title: "使用例") {
                CodeExample(code: """
>>>>>>> upstream/main
                    @State private var selectedColor: String?
                    @State private var showColorPicker = false

                    Button("Select Color") {
                        showColorPicker = true
                    }
                    .colorPicker(
                        preset: .tagFriendly,
                        selectedColor: $selectedColor,
                        isPresented: $showColorPicker
                    )
                    """)
<<<<<<< HEAD

                Text("Presets:")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                Text("• .tagFriendly – 10 colors suitable for tags and categories.")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                Text("• .allPrimitives – all primitive colors (11 colors).")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
=======
>>>>>>> upstream/main
            }
        }
    }

    @ViewBuilder
    private func colorPreview(selectedColor: String?) -> some View {
        HStack(spacing: spacing.md) {
            if let hex = selectedColor {
                Circle()
                    .fill(Color(hex: hex))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(colors.outline.opacity(0.2), lineWidth: 1)
                    )

                Text(hex)
                    .typography(.bodyMedium)
                    .foregroundStyle(colors.onSurface)
                    .fontDesign(.monospaced)
            } else {
                Text("色を選択してください")
                    .typography(.bodyMedium)
                    .foregroundStyle(colors.onSurfaceVariant)
            }

            Spacer()
        }
        .padding(spacing.md)
        .background(colors.surfaceVariant.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: radius.lg))
    }
}

#Preview {
    NavigationStack {
        ColorPickerCatalogView()
            .theme(ThemeProvider())
    }
}
