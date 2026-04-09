import SwiftUI

/// Environment key used to expose the root-installed notification presenter.
private struct NotifyKey: EnvironmentKey {
    static let defaultValue: NotificationPresenter? = nil
}

public extension EnvironmentValues {
    /// Presenter-backed notification entry point for Toast + Snackbar.
    var notify: NotificationPresenter? {
        get { self[NotifyKey.self] }
        set { self[NotifyKey.self] = newValue }
    }
}
