import SwiftUI

/// Semantic tone for compact status UI.
public enum StatusPillTone: Sendable {
    case info
    case success
    case warning
    case error
}

/// Size variant for ``StatusPill``.
public enum StatusPillSize: Sendable {
    case small
    case medium

    fileprivate var typography: Typography {
        switch self {
        case .small: return .labelSmall
        case .medium: return .labelMedium
        }
    }

    fileprivate var horizontalPadding: CGFloat {
        switch self {
        case .small: return 10
        case .medium: return 12
        }
    }

    fileprivate var verticalPadding: CGFloat {
        switch self {
        case .small: return 5
        case .medium: return 6
        }
    }

    fileprivate var iconPointSize: CGFloat {
        switch self {
        case .small: return 11
        case .medium: return 12
        }
    }
}

/// Compact semantic status pill.
///
/// Use when a screen needs a small semantic state marker such as Ready,
/// Almost Ready, Warning, or Synced. Unlike a filled `Chip`, the color
/// treatment follows semantic status tones instead of always using the brand
/// primary color.
///
/// ## Usage
/// ```swift
/// StatusPill("Ready", tone: .success)
/// StatusPill("Almost Ready", tone: .warning, systemImage: "exclamationmark.circle.fill")
/// ```
public struct StatusPill: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    private let title: String
    private let tone: StatusPillTone
    private let systemImage: String?
    private let size: StatusPillSize

    public init(
        _ title: String,
        tone: StatusPillTone,
        systemImage: String? = nil,
        size: StatusPillSize = .medium
    ) {
        self.title = title
        self.tone = tone
        self.systemImage = systemImage
        self.size = size
    }

    public var body: some View {
        HStack(spacing: spacing.xs) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: size.iconPointSize, weight: .semibold))
            }

            Text(title)
                .typography(size.typography)
                .fontWeight(.medium)
        }
        .foregroundStyle(foregroundColor)
        .padding(.horizontal, size.horizontalPadding)
        .padding(.vertical, size.verticalPadding)
        .background(backgroundColor)
        .clipShape(Capsule())
    }

    private var backgroundColor: Color {
        toneColor.opacity(0.15)
    }

    private var foregroundColor: Color {
        toneColor
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
    VStack(spacing: 12) {
        StatusPill("Ready", tone: .success)
        StatusPill("Almost Ready", tone: .warning, systemImage: "exclamationmark.circle.fill")
        StatusPill("Needs Attention", tone: .error, systemImage: "xmark.circle.fill")
        StatusPill("Synced", tone: .info, systemImage: "checkmark.icloud.fill", size: .small)
    }
    .padding()
    .theme(ThemeProvider())
}
