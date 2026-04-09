import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Presenter-backed notification orchestration for Toast + Snackbar.
///
/// Install once at app root via `installNotifications()`, then trigger
/// transient notifications from any child view using `@Environment(\.notify)`.
///
/// Unlike `StatusBanner`, which represents persistent state, this presenter is
/// only for short-lived user feedback:
/// - `Toast` for top, action-free feedback
/// - `Snackbar` for bottom, action-capable feedback
///
/// ## Usage
/// ```swift
/// @main
/// struct MyApp: App {
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///                 .installNotifications()
///         }
///     }
/// }
///
/// struct ContentView: View {
///     @Environment(\.notify) private var notify
///
///     var body: some View {
///         VStack {
///             Button("Save") {
///                 notify?.toast("Saved", level: .success)
///             }
///
///             Button("Delete") {
///                 notify?.snackbar(
///                     "Deleted",
///                     action: .init(title: "Undo") {
///                         await restore()
///                     }
///                 )
///             }
///         }
///     }
/// }
/// ```
///
/// ## Design Guidelines
/// - Use `Toast` for short, passive feedback
/// - Use `Snackbar` when the user needs one action (undo, retry, view)
/// - Keep `StatusBanner` separate for persistent state
@MainActor
@Observable
public final class NotificationPresenter {
    /// Internal toast state used by the root host renderer.
    let toastState: ToastState

    /// Internal snackbar state used by the root host renderer.
    let snackbarState: SnackbarState

    /// Pending snackbar queue. Toasts intentionally do not queue in v1.
    private let queue = NotifyQueue()

    /// Fingerprint of the most recently triggered toast.
    private var lastToastFingerprint: String?

    /// Timestamp for the most recently triggered toast.
    private var lastToastTimestamp: Date?

    /// Short window used to suppress duplicate toast spam.
    private let duplicateToastSuppressionWindow: TimeInterval = 0.5

    /// Small delay between snackbar dismissal and the next presentation so
    /// transitions feel natural and don't visually collide.
    private let snackbarTransitionDelay: TimeInterval = 0.2

    /// Creates a presenter for root-installed transient notifications.
    ///
    /// The presenter owns Toast + Snackbar orchestration. `StatusBanner`
    /// intentionally remains separate because it models persistent state, not
    /// event-driven feedback.
    public init(
        toastState: ToastState = ToastState(),
        snackbarState: SnackbarState = SnackbarState()
    ) {
        self.toastState = toastState
        self.snackbarState = snackbarState

        self.snackbarState.didDismiss = { [weak self] in
            guard let self else { return }
            Task { @MainActor in
                await self.presentNextSnackbarIfNeeded()
            }
        }
    }

    // MARK: - Public API

    /// Shows a toast at the top of the screen.
    ///
    /// - Parameters:
    ///   - message: The short feedback message to display
    ///   - level: Severity level controlling icon, color, and automatic haptics
    ///   - haptics: Haptic behavior for this toast
    ///   - duration: Seconds until auto-dismiss
    public func toast(
        _ message: String,
        level: ToastLevel = .info,
        haptics: NotificationHaptics = .automatic,
        duration: TimeInterval = 3
    ) {
        let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let item = NotificationQueueItem.toast(
            message: trimmed,
            level: level,
            haptics: haptics,
            duration: duration
        )

        guard !shouldSuppressToast(item) else { return }

        announce(trimmed)
        playHaptics(for: level, policy: haptics)
        toastState.show(message: trimmed, level: level, duration: duration)
    }

    /// Shows a snackbar at the bottom of the screen.
    ///
    /// Snackbars queue by default in the presenter so action-capable messages
    /// do not overwrite each other.
    ///
    /// - Parameters:
    ///   - message: The message to display
    ///   - action: Optional single action button
    ///   - duration: Seconds until auto-dismiss
    public func snackbar(
        _ message: String,
        action: NotifyAction? = nil,
        duration: TimeInterval = 5
    ) {
        let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let item = NotificationQueueItem.snackbar(
            message: trimmed,
            action: action,
            duration: duration
        )

        if snackbarState.isVisible {
            queue.enqueue(item)
            return
        }

        presentSnackbar(item)
    }

    /// Dismisses the currently visible presenter-backed notifications.
    ///
    /// This clears the visible toast and snackbar states. Pending queued
    /// snackbars remain queued.
    public func dismissCurrent() {
        toastState.dismiss()
        snackbarState.dismiss()
    }

    // MARK: - Toast policy

    /// Returns `true` when a toast should be suppressed as a near-immediate
    /// duplicate of the previous one.
    private func shouldSuppressToast(_ item: NotificationQueueItem) -> Bool {
        guard case let .toast(message, level, _, _) = item else { return false }

        let fingerprint = "\(level)-\(message)"
        let now = Date()

        defer {
            lastToastFingerprint = fingerprint
            lastToastTimestamp = now
        }

        guard let lastToastFingerprint,
              let lastToastTimestamp else {
            return false
        }

        return fingerprint == lastToastFingerprint
            && now.timeIntervalSince(lastToastTimestamp) < duplicateToastSuppressionWindow
    }

    // MARK: - Snackbar routing

    /// Converts a queued snackbar item into the existing state-driven renderer.
    private func presentSnackbar(_ item: NotificationQueueItem) {
        guard case let .snackbar(message, action, duration) = item else { return }

        announce(message)

        snackbarState.show(
            message: message,
            primaryAction: action.map { action in
                SnackbarAction(title: action.title) {
                    await action.handler()
                }
            },
            duration: duration
        )
    }

    /// Presents the next queued snackbar after the current one disappears.
    private func presentNextSnackbarIfNeeded() async {
        guard !snackbarState.isVisible else { return }
        guard let next = queue.dequeue() else { return }

        let delay = UInt64(snackbarTransitionDelay * 1_000_000_000)
        try? await Task.sleep(nanoseconds: delay)

        guard !snackbarState.isVisible else {
            queue.enqueue(next)
            return
        }

        presentSnackbar(next)
    }

    // MARK: - Feedback helpers

    /// Announces the notification message for VoiceOver users.
    private func announce(_ message: String) {
        #if canImport(UIKit)
        UIAccessibility.post(notification: .announcement, argument: message)
        #endif
    }

    /// Triggers lightweight haptic feedback for toast notifications.
    private func playHaptics(for level: ToastLevel, policy: NotificationHaptics) {
        guard policy == .automatic else { return }
        #if canImport(UIKit)
        switch level {
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .info:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        #endif
    }
}
