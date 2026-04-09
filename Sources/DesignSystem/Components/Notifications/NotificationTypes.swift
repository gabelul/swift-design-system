import SwiftUI

/// Notification haptics policy for presenter-driven notifications.
public enum NotificationHaptics: Sendable {
    /// Let the presenter choose the appropriate haptic for the notification.
    case automatic

    /// Disable haptics for this notification.
    case off
}

/// Async action payload for presenter-driven snackbars.
///
/// Use this when a snackbar needs a single follow-up action such as
/// "Undo", "Retry", or "View".
public struct NotifyAction {
    /// Title shown on the snackbar action button.
    public let title: String

    /// Async handler invoked when the action is tapped.
    public let handler: @MainActor () async -> Void

    /// Creates a snackbar action.
    ///
    /// - Parameters:
    ///   - title: The button title shown in the snackbar
    ///   - handler: Async handler executed when the action is tapped
    public init(
        title: String,
        handler: @escaping @MainActor () async -> Void
    ) {
        self.title = title
        self.handler = handler
    }
}

enum NotificationQueueItem {
    /// A top, action-free toast notification.
    case toast(
        message: String,
        level: ToastLevel,
        haptics: NotificationHaptics,
        duration: TimeInterval
    )

    /// A bottom snackbar notification with an optional single action.
    case snackbar(
        message: String,
        action: NotifyAction?,
        duration: TimeInterval
    )

    var message: String {
        switch self {
        case .toast(let message, _, _, _), .snackbar(let message, _, _):
            return message
        }
    }
}
