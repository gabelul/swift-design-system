import SwiftUI

/// Catalog info section view
struct InfoSectionView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    var body: some View {
<<<<<<< HEAD
        VStack(alignment: .leading, spacing: 12) {
            Text("Info")
=======
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("情報")
>>>>>>> upstream/main
                .typography(.titleMedium)
                .foregroundStyle(colors.onSurface)
                .padding(.horizontal, spacing.lg)

            VStack(spacing: 0) {
<<<<<<< HEAD
                InfoRow(label: "Platform", value: "iOS 17+, macOS 14+")
                Divider().padding(.leading, 16)
=======
                InfoRow(label: "プラットフォーム", value: "iOS 17+, macOS 14+")
                Divider().padding(.leading, spacing.lg)
>>>>>>> upstream/main
                InfoLinkRow(
                    label: "Repository",
                    value: "GitHub",
                    url: "https://github.com/no-problem-dev/swift-design-system"
                )
                Divider().padding(.leading, spacing.lg)
                InfoLinkRow(
                    label: "Documentation",
                    value: "DocC",
                    url: "https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/"
                )
            }
            .background(colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: radius.md))
            .elevation(.level1)
            .padding(.horizontal, spacing.lg)
        }
    }
}
