import SwiftUI

/// Full-screen error state with retry action
///
/// Shown when an entire screen or section fails to load.
///
/// ## Usage
/// ```swift
/// ErrorState(onRetry: { await reload() })
///
/// // Custom messaging
/// ErrorState(
///     title: "Can't load profile",
///     message: "Check your connection and try again",
///     icon: "wifi.slash",
///     onRetry: { await reload() }
/// )
/// ```
public struct ErrorState: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    private let title: String
    private let message: String?
    private let icon: String
    private let retryLabel: String
    private let onRetry: (() -> Void)?

    /// Creates an error state view
    ///
    /// - Parameters:
    ///   - title: Error heading (default: "Something went wrong")
    ///   - message: Optional description text
    ///   - icon: SF Symbol name (default: "exclamationmark.triangle.fill")
    ///   - retryLabel: Retry button text (default: "Try Again")
    ///   - onRetry: Retry handler (hide button if nil)
    public init(
        title: String = "Something went wrong",
        message: String? = nil,
        icon: String = "exclamationmark.triangle.fill",
        retryLabel: String = "Try Again",
        onRetry: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.icon = icon
        self.retryLabel = retryLabel
        self.onRetry = onRetry
    }

    public var body: some View {
        VStack(spacing: spacing.lg) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(colors.error.opacity(0.7))

            VStack(spacing: spacing.sm) {
                Text(title)
                    .typography(.titleLarge)
                    .foregroundStyle(colors.onSurface)

                if let message {
                    Text(message)
                        .typography(.bodyMedium)
                        .foregroundStyle(colors.onSurfaceVariant)
                        .multilineTextAlignment(.center)
                }
            }

            if let onRetry {
                Button(retryLabel) { onRetry() }
                    .buttonStyle(.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(spacing.xl)
    }
}

#Preview {
    VStack(spacing: 32) {
        ErrorState(onRetry: {})

        ErrorState(
            title: "No Connection",
            message: "Check your internet and try again",
            icon: "wifi.slash",
            onRetry: {}
        )
    }
    .theme(ThemeProvider())
}
