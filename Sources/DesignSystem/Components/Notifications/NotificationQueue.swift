import Foundation

/// Minimal FIFO queue for presenter-managed snackbars.
///
/// Toasts intentionally do not queue in v1 — they replace the current toast.
@MainActor
final class NotifyQueue {
    private var pendingSnackbars: [NotificationQueueItem] = []

    /// Adds a snackbar item to the tail of the queue.
    func enqueue(_ item: NotificationQueueItem) {
        pendingSnackbars.append(item)
    }

    /// Returns the next queued snackbar item, if any.
    func dequeue() -> NotificationQueueItem? {
        guard !pendingSnackbars.isEmpty else { return nil }
        return pendingSnackbars.removeFirst()
    }
}
