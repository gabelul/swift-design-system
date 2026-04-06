import SwiftUI

/// Observable object that manages the display state of Snackbar
///
/// Centrally manages states such as Snackbar visibility, auto-dismiss timers, etc.
///
/// ## Usage Example
/// ```swift
/// @State private var snackbarState = SnackbarState()
///
/// // Show Snackbar
/// snackbarState.show(
///     message: "Saved successfully",
///     duration: 3.0
/// )
///
/// // Show with action
/// snackbarState.show(
///     message: "Deleted successfully",
///     primaryAction: SnackbarAction(title: "Undo") {
///         // Undo processing
///     },
///     duration: 5.0
/// )
/// ```
@MainActor
@Observable
public final class SnackbarState {
    /// Whether the Snackbar is visible
    public private(set) var isVisible: Bool = false

    /// The message to display
    public private(set) var message: String = ""

    /// Primary action (main action button)
    public private(set) var primaryAction: SnackbarAction?

    /// Secondary action (auxiliary action button)
    public private(set) var secondaryAction: SnackbarAction?

    /// Auto-dismiss timer
    private var dismissTask: Task<Void, Never>?

    public init() {}

    /// Shows the Snackbar
    ///
    /// - Parameters:
    ///   - message: The message to display
    ///   - primaryAction: Primary action (optional)
    ///   - secondaryAction: Secondary action (optional)
    ///   - duration: Seconds until auto-dismiss (default: 5 seconds)
    public func show(
        message: String,
        primaryAction: SnackbarAction? = nil,
        secondaryAction: SnackbarAction? = nil,
        duration: TimeInterval = 5.0
    ) {
        // Cancel existing timer
        dismissTask?.cancel()

        // Update state
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        self.isVisible = true

        // Set auto-dismiss timer
        dismissTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            if !Task.isCancelled {
                self.dismiss()
            }
        }
    }

    /// Hides the Snackbar
    public func dismiss() {
        dismissTask?.cancel()
        isVisible = false
    }
}

/// Snackbar action button
public struct SnackbarAction {
    /// Title of the action button
    public let title: String

    /// Handler to execute when the action is triggered
    public let action: @MainActor () async -> Void

    public init(title: String, action: @escaping @MainActor () async -> Void) {
        self.title = title
        self.action = action
    }
}
