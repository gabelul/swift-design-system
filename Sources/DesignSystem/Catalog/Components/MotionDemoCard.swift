import SwiftUI

/// Motion demo card
///
/// Interactive card that lets you experience each motion preset.
struct MotionDemoCard: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    let spec: MotionSpec
    @State private var isAnimating = false

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: spacing.xs) {
                        Text(spec.name)
                            .typography(.titleSmall)
                            .foregroundStyle(colors.onSurface)

                        Text(spec.usage)
                            .typography(.bodySmall)
                            .foregroundStyle(colors.onSurfaceVariant)
                            .lineLimit(2)
                            .minimumScaleFactor(0.9)
                    }

                    Spacer()

                    // 仕様表示
                    VStack(alignment: .trailing, spacing: spacing.xs) {
