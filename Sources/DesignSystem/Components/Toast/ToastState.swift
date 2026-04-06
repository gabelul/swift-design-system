import SwiftUI

/// Toast severity level, determines icon and color
public enum ToastLevel: Sendable {
    case info, success, warning, error

    /// Default SF Symbol for each level
    var icon: String {
        switch self {
        case .info: return "info.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

/// Observable state manager for Toast notifications
///
/// Manages visibility, auto-dismiss timers, and message content.
/// Follows the same pattern as `SnackbarState`.
///
/// ## Usage
/// ```swift
/// @State private var toastState = ToastState()
///
/// // Show a toast
/// toastState.show(message: "Saved", level: .success)
///
/// // In the view body
/// Toast(state: toastState)
/// ```
@MainActor
@Observable
public final class ToastState {
    /// Whether the toast is visible
    public private(set) var isVisible: Bool = false

    /// The message to display
    public private(set) var message: String = ""

    /// Severity level
    public private(set) var level: ToastLevel = .info

    /// Custom icon override (nil uses level default)
    public private(set) var icon: String? = nil

    /// Auto-dismiss timer
    private var dismissTask: Task<Void, Never>?

    public init() {}

    /// Shows a toast notification
    ///
    /// - Parameters:
    ///   - message: The message to display
    ///   - level: Severity level (default: .info)
    ///   - icon: Custom SF Symbol name (nil uses level default)
    ///   - duration: Seconds until auto-dismiss (default: 3 seconds)
    public func show(
        message: String,
        level: ToastLevel = .info,
        icon: String? = nil,
        duration: TimeInterval = 3.0
    ) {
        dismissTask?.cancel()

        self.message = message
        self.level = level
        self.icon = icon
        self.isVisible = true

        dismissTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            if !Task.isCancelled {
                self.dismiss()
            }
        }
    }

    /// Hides the toast
    public func dismiss() {
        dismissTask?.cancel()
        isVisible = false
    }
}
