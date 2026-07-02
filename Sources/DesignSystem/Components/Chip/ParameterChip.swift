import SwiftUI

/// A parameter chip that summarizes the current value.
///
/// Uses the value itself as the label so the selected value stays readable even
/// when collapsed. It's a display-only view with no action of its own — use it
/// as the label of a `Button` or `Menu`.
///
/// ```swift
/// Menu {
///     Picker("", selection: $format) { ... }
/// } label: {
///     ParameterChip("A2UI", systemImage: "sparkles")
/// }
/// ```
public struct ParameterChip: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacingScale

    private let value: String
    private let systemImage: String?
    private let prominent: Bool

    /// - Parameters:
    ///   - value: Summary label for the current value.
    ///   - systemImage: Leading icon.
    ///   - prominent: Whether to emphasize with the primary tint.
    public init(_ value: String, systemImage: String? = nil, prominent: Bool = false) {
        self.value = value
        self.systemImage = systemImage
        self.prominent = prominent
    }

    public var body: some View {
        HStack(spacing: spacingScale.xxs) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: 11, weight: .semibold))
            }
            Text(value)
                .typography(.labelMedium)
            Image(systemName: "chevron.down")
                .font(.system(size: 8, weight: .bold))
                .foregroundStyle(colorPalette.onSurfaceVariant)
        }
        .foregroundStyle(prominent ? colorPalette.primary : colorPalette.onSurface)
        .padding(.horizontal, spacingScale.sm)
        .frame(height: 30)
        .background { background }
        .contentShape(Capsule())
    }

    @ViewBuilder private var background: some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            Capsule()
                .fill(.clear)
                .glassEffect(
                    prominent
                        ? .regular.tint(colorPalette.primary.opacity(0.15)).interactive(true)
                        : .regular.interactive(true),
                    in: Capsule()
                )
        } else {
            Capsule()
                .fill(colorPalette.surfaceVariant.opacity(0.8))
                .background(.ultraThinMaterial, in: Capsule())
        }
    }
}

#Preview {
    HStack {
        ParameterChip("A2UI", systemImage: "sparkles", prominent: true)
        ParameterChip("Single")
        ParameterChip("Agent 3", systemImage: "person.3.fill")
    }
    .padding()
    .theme(ThemeProvider())
}
