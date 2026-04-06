import SwiftUI

/// Status banner severity level
public enum StatusBannerLevel: Sendable {
    case info, success, warning, error
}

/// Horizontal banner for displaying status messages
///
/// A compact, colored bar for surfacing alerts, connectivity status,
/// or inline feedback. Appears with an icon, message, and optional action.
///
/// ## Usage
/// ```swift
/// StatusBanner("Saved successfully", level: .success)
///
/// StatusBanner("No internet connection", level: .error, icon: "wifi.slash")
///
/// StatusBanner(
///     "New version available",
///     level: .info,
///     actionLabel: "Update"
/// ) {
///     openAppStore()
/// }
/// ```
public struct StatusBanner: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    private let message: String
    private let level: StatusBannerLevel
    private let icon: String?
    private let isDismissible: Bool
    private let actionLabel: String?
    private let action: (() -> Void)?

    @State private var isVisible: Bool = true

    /// Creates a status banner
    ///
    /// - Parameters:
    ///   - message: The status message to display
    ///   - level: Severity level that determines color (default: .info)
    ///   - icon: SF Symbol name (auto-derived from level if nil)
    ///   - isDismissible: Show a dismiss button (default: false)
    ///   - actionLabel: Optional action button text
    ///   - action: Action button handler
    public init(
        _ message: String,
        level: StatusBannerLevel = .info,
        icon: String? = nil,
        isDismissible: Bool = false,
        actionLabel: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.message = message
        self.level = level
        self.icon = icon
        self.isDismissible = isDismissible
        self.actionLabel = actionLabel
        self.action = action
    }

    public var body: some View {
        if isVisible {
            HStack(spacing: spacing.sm) {
                Image(systemName: resolvedIcon)
                    .font(.system(size: 16, weight: .semibold))

                Text(message)
                    .typography(.bodySmall)
                    .lineLimit(2)

                Spacer()

                if let actionLabel, let action {
                    Button(actionLabel) { action() }
                        .typography(.labelMedium)
                        .foregroundStyle(foregroundColor)
                }

                if isDismissible {
                    Button {
                        withAnimation { isVisible = false }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .buttonStyle(.plain)
                }
            }
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, spacing.lg)
            .padding(.vertical, spacing.md)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: radius.md))
        }
    }

    // MARK: - Level-based styling

    private var resolvedIcon: String {
        icon ?? defaultIcon
    }

    private var defaultIcon: String {
        switch level {
        case .info: return "info.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error: return "xmark.circle.fill"
        }
    }

    private var backgroundColor: Color {
        switch level {
        case .info: return colors.info.opacity(0.15)
        case .success: return colors.success.opacity(0.15)
        case .warning: return colors.warning.opacity(0.15)
        case .error: return colors.error.opacity(0.15)
        }
    }

    private var foregroundColor: Color {
        switch level {
        case .info: return colors.info
        case .success: return colors.success
        case .warning: return colors.warning
        case .error: return colors.error
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        StatusBanner("Upload complete", level: .success)
        StatusBanner("Check your connection", level: .warning, isDismissible: true)
        StatusBanner("Failed to load", level: .error, actionLabel: "Retry") {}
        StatusBanner("New features available", level: .info)
    }
    .padding()
    .theme(ThemeProvider())
}
