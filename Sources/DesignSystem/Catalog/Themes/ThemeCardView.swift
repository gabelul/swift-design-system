import SwiftUI

/// Theme card view
///
/// Individual theme card displayed in the theme gallery.
/// Displays theme name, description, and preview colors.
struct ThemeCardView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

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

                // プレビューカラードット
                HStack(spacing: spacing.sm) {
