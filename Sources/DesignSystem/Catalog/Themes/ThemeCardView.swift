import SwiftUI

/// Theme card view
///
/// Individual theme card displayed in the theme gallery.
/// Displays theme name, description, and preview colors.
struct ThemeCardView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    let theme: any Theme
    let isActive: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: spacing.sm) {
                // Header (name and active mark)
                HStack {
                    Text(theme.name)
                        .typography(.titleSmall)
                        .foregroundStyle(colors.onSurface)

                    Spacer()

                    if isActive {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(colors.primary)
                            .font(.title3)
                    }
                }

                // Preview color dots
                HStack(spacing: 6) {
                    ForEach(0 ..< min(theme.previewColors.count, 5), id: \.self) { index in
                        Circle()
                            .fill(theme.previewColors[index])
                            .frame(width: 24, height: 24)
                            .overlay(
                                Circle()
                                    .strokeBorder(colors.outline, lineWidth: 1)
                            )
                    }
                }

                // Description
                Text(theme.description)
                    .typography(.bodySmall)
                    .foregroundStyle(colors.onSurfaceVariant)
                    .lineLimit(2)
            }
            .padding(spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(
                        isActive ? colors.primary : colors.outline,
                        lineWidth: isActive ? 2 : 1
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var themeProvider = ThemeProvider()

    VStack(spacing: 16) {
        ThemeCardView(
            theme: DefaultTheme(),
            isActive: true,
            onTap: {}
        )

        ThemeCardView(
            theme: OceanTheme(),
            isActive: false,
            onTap: {}
        )
    }
    .padding()
    .theme(themeProvider)
}
