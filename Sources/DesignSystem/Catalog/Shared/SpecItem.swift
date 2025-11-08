import SwiftUI

/// 仕様項目を表示するビュー
struct SpecItem: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    let label: String
    let value: String
    var description: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: spacing.xs) {
            HStack {
                Text(label)
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurface)

                Spacer()

                Text(value)
                    .typography(.bodySmall)
                    .fontDesign(.monospaced)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
            }

            if let description {
                Text(description)
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant.opacity(0.7))
            }
        }
    }
}
