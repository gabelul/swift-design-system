import SwiftUI

/// Centered loading spinner with optional message
///
/// A simple loading indicator using the system ProgressView,
/// styled with the theme's primary color.
///
/// ## Usage
/// ```swift
/// LoadingState()
///
/// LoadingState(message: "Loading items...")
/// ```
public struct LoadingState: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    private let message: String?

    /// Creates a loading state view
    ///
    /// - Parameter message: Optional text below the spinner
    public init(message: String? = nil) {
        self.message = message
    }

    public var body: some View {
        VStack(spacing: spacing.lg) {
            ProgressView()
                .controlSize(.large)
                .tint(colors.primary)

            if let message {
                Text(message)
                    .typography(.bodyMedium)
                    .foregroundStyle(colors.onSurfaceVariant)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(spacing.xl)
    }
}

#Preview {
    VStack(spacing: 48) {
        LoadingState()
        LoadingState(message: "Loading your data...")
    }
    .theme(ThemeProvider())
}
