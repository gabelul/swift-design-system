import SwiftUI

/// Size variant for ``IconTile``.
public enum IconTileSize: Sendable {
    case small
    case medium
    case large

    fileprivate var tileSize: CGFloat {
        switch self {
        case .small: return 36
        case .medium: return 44
        case .large: return 56
        }
    }

    fileprivate var iconPointSize: CGFloat {
        switch self {
        case .small: return 14
        case .medium: return 17
        case .large: return 20
        }
    }

    fileprivate var cornerRadius: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 14
        case .large: return 18
        }
    }
}

/// Semantic rounded-square icon tile.
///
/// Use when a screen needs a small rounded-square icon treatment for feature
/// highlights, readiness rows, or grouped benefit lists. Keep `IconBadge` for
/// circular treatments and `StatusPill` for text-based semantic state.
///
/// ## Usage
/// ```swift
/// IconTile(systemName: "checkmark", tone: .success)
/// IconTile(systemName: "lock.fill", tone: .info, size: .medium)
/// ```
public struct IconTile: View {
    @Environment(\.colorPalette) private var colors

    private let systemName: String
    private let tone: StatusPillTone
    private let size: IconTileSize

    public init(
        systemName: String,
        tone: StatusPillTone,
        size: IconTileSize = .medium
    ) {
        self.systemName = systemName
        self.tone = tone
        self.size = size
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: size.cornerRadius)
            .fill(toneColor.opacity(0.15))
            .frame(width: size.tileSize, height: size.tileSize)
            .overlay {
                Image(systemName: systemName)
                    .font(.system(size: size.iconPointSize, weight: .semibold))
                    .foregroundStyle(toneColor)
            }
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
    HStack(spacing: 16) {
        IconTile(systemName: "checkmark", tone: .success, size: .small)
        IconTile(systemName: "lock.fill", tone: .info)
        IconTile(systemName: "exclamationmark", tone: .warning)
        IconTile(systemName: "xmark", tone: .error, size: .large)
    }
    .padding()
    .theme(ThemeProvider())
}
