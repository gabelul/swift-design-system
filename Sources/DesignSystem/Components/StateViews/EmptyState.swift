import SwiftUI

/// Full-screen empty state with icon, title, message, and optional action
///
/// Used when a list, search, or content area has nothing to show.
///
/// ## Usage
/// ```swift
/// // Basic
/// EmptyState(icon: "tray", title: "No Items")
///
/// // With message and action
/// EmptyState(
///     icon: "magnifyingglass",
///     title: "No Results",
///     message: "Try a different search term"
/// ) {
///     Button("Clear Search") { clearSearch() }
///         .buttonStyle(.secondary)
/// }
/// ```
public struct EmptyState<Action: View>: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    private let icon: String
    private let title: String
    private let message: String?
    private let action: Action

    /// Creates an empty state with an optional action
    ///
    /// - Parameters:
    ///   - icon: SF Symbol name for the illustration
    ///   - title: Main heading text
    ///   - message: Optional description text
    ///   - action: Optional action view (typically a Button)
    public init(
        icon: String,
        title: String,
        message: String? = nil,
        @ViewBuilder action: () -> Action
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.action = action()
    }

    public var body: some View {
        VStack(spacing: spacing.lg) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(colors.primary.opacity(0.6))

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

            action
        }
        .frame(maxWidth: .infinity)
        .padding(spacing.xl)
    }
}

// MARK: - Convenience without action

public extension EmptyState where Action == EmptyView {
    /// Creates an empty state without an action button
    ///
    /// - Parameters:
    ///   - icon: SF Symbol name
    ///   - title: Main heading text
    ///   - message: Optional description text
    init(icon: String, title: String, message: String? = nil) {
        self.init(icon: icon, title: title, message: message) {
            EmptyView()
        }
    }
}

#Preview {
    VStack(spacing: 32) {
        EmptyState(icon: "tray", title: "No Items", message: "Add your first item to get started")

        EmptyState(icon: "magnifyingglass", title: "No Results", message: "Try different keywords") {
            Button("Clear Search") {}
                .buttonStyle(.secondary)
        }
    }
    .theme(ThemeProvider())
}
