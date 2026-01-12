import SwiftUI

/// ViewModifier for displaying color picker
///
/// ## Usage Examples
/// ```swift
/// struct MyView: View {
///     @State private var selectedColor: String?
///     @State private var showColorPicker = false
///
///     var body: some View {
///         Button("Select Color") {
///             showColorPicker = true
///         }
///         .colorPicker(
///             preset: .tagFriendly,
///             selectedColor: $selectedColor,
///             isPresented: $showColorPicker
///         )
///     }
/// }
/// ```
public struct ColorPickerModifier: ViewModifier {
    let preset: ColorPreset
    @Binding var selectedColor: String?
    @Binding var isPresented: Bool

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                DSColorPickerView(
                    preset: preset,
                    selectedColor: $selectedColor,
                    isPresented: $isPresented
                )
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
    }
}

// MARK: - View Extension

public extension View {
    /// Displays color picker
    ///
    /// - Parameters:
    ///   - preset: Color preset to display (default: `.tagFriendly`)
    ///   - selectedColor: Hex code of selected color
    ///   - isPresented: Picker display state
    /// - Returns: View with color picker added
    func colorPicker(
        preset: ColorPreset = .tagFriendly,
        selectedColor: Binding<String?>,
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(ColorPickerModifier(
            preset: preset,
            selectedColor: selectedColor,
            isPresented: isPresented
        ))
    }
}

// MARK: - Internal View

/// Internal implementation view of color picker (private)
struct DSColorPickerView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius
    @Environment(\.dismiss) private var dismiss

    let preset: ColorPreset
    @Binding var selectedColor: String?
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: spacing.lg) {
                    // Preview section
                    if let selectedHex = selectedColor {
                        previewSection(hex: selectedHex)
                    }

                    // Color grid
                    colorGridSection
                }
                .padding(spacing.md)
            }
            .background(colors.background)
            .navigationTitle("Select Color")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(colors.onSurfaceVariant)
                }

                ToolbarItem(placement: .confirmationAction) {
                    if selectedColor != nil {
                        Button("Clear") {
                            selectedColor = nil
                        }
                        .foregroundColor(colors.primary)
                    }
                }
            }
        }
    }

    private func previewSection(hex: String) -> some View {
        HStack(spacing: spacing.md) {
            Circle()
                .fill(Color(hex: hex))
                .frame(width: 60, height: 60)
                .overlay(
                    Circle()
                        .stroke(colors.outline.opacity(0.2), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: spacing.xs) {
                Text("Selected Color")
                    .font(.caption)
                    .foregroundColor(colors.onSurfaceVariant)
                Text(hex.uppercased())
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(colors.onSurface)
            }

            Spacer()
        }
        .padding(spacing.md)
        .background(colors.surfaceVariant.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: radius.md))
    }

    private var colorGridSection: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: spacing.md), count: 5),
            spacing: spacing.md
        ) {
            ForEach(preset.colors) { colorItem in
                ColorCircleButton(
                    colorItem: colorItem,
                    isSelected: selectedColor == colorItem.hex,
                    onTap: {
                        selectedColor = colorItem.hex
                    }
                )
            }
        }
    }
}

// MARK: - Color Circle Button

private struct ColorCircleButton: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    let colorItem: ColorItem
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(spacing: spacing.xs) {
                Circle()
                    .fill(Color(hex: colorItem.hex))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Circle()
                            .stroke(
                                isSelected ? colors.onSurface : Color.clear,
                                lineWidth: 3
                            )
                    )
                    .overlay(
                        Circle()
                            .stroke(colors.outline.opacity(0.2), lineWidth: 1)
                    )

                Text(colorItem.name)
                    .font(.caption2)
                    .foregroundColor(colors.onSurfaceVariant)
                    .lineLimit(1)
            }
        }
    }
}
