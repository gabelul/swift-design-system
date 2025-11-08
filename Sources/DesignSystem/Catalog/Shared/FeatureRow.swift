import SwiftUI

/// 機能行を表示するビュー
struct FeatureRow: View {
    @Environment(\.spacingScale) private var spacing

    let icon: String
    let title: String
    let color: Color

    var body: some View {
        HStack(spacing: spacing.sm) {
            Image(systemName: icon)
                .foregroundStyle(color)

            Text(title)
                .typography(.bodyMedium)
        }
    }
}
