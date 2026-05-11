import SwiftUI

/// Semantic inset callout block.
///
/// Use for short contextual beats inside a card or page when the UI needs a
/// lightly tinted semantic container instead of a banner or pill.
///
/// ## Usage
/// ```swift
/// InsetCallout(
///     tone: .info,
///     systemImage: "lock.fill",
///     title: "Private sync"
/// ) {
///     Text("Only you can see this data.")
/// }
/// ```
public struct InsetCallout<Content: View>: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    private let tone: StatusPillTone
    private let systemImage: String?
    private let title: String?
    private let content: Content

    public init(
        tone: StatusPillTone,
        systemImage: String? = nil,
        title: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.tone = tone
        self.systemImage = systemImage
        self.title = title
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            if systemImage != nil || title != nil {
                HStack(spacing: spacing.xs) {
                    if let systemImage {
                        Image(systemName: systemImage)
                            .font(.system(size: 14, weight: .semibold))
                    }

                    if let title {
                        Text(title)
                            .typography(.labelLarge)
                            .fontWeight(.semibold)
                    }
                }
                .foregroundStyle(toneColor)
            }

            content
                .foregroundStyle(colors.onSurface)
        }
        .padding(spacing.lg)
        .background(toneColor.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: radius.lg))
    }

    private var toneColor: Color {
        switch tone {
        case .info: return colors.info
        case .success: return colors.success
        case .warning: return colors.warning
        case .error: return colors.error
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        InsetCallout(tone: .info, systemImage: "lock.fill", title: "Private sync") {
            Text("Only you can see this data, and it stays in your iCloud account.")
                .typography(.bodySmall)
        }

        InsetCallout(tone: .warning, systemImage: "exclamationmark.circle.fill", title: "Almost ready") {
            Text("Add one more record to complete setup.")
                .typography(.bodySmall)
        }
    }
    .padding()
    .theme(ThemeProvider())
}
