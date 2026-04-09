import SwiftUI

/// Root host that installs presenter-backed Toast + Snackbar notifications.
///
/// This host should usually sit at the app root so child views can use
/// `@Environment(\.notify)` without local notification state.
///
/// ## Usage
/// ```swift
/// ContentView()
///     .installNotifications()
/// ```
public struct NotificationHost<Content: View>: View {
    private let content: Content

    /// Shared presenter installed for the wrapped view hierarchy.
    @State private var presenter = NotificationPresenter()

    /// Wraps content with a root-level notification host.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .environment(\.notify, presenter)
            .overlay(alignment: .top) {
                // Presenter-backed toast lane.
                Toast(state: presenter.toastState)
            }
            .overlay(alignment: .bottom) {
                // Presenter-backed snackbar lane.
                Snackbar(state: presenter.snackbarState)
            }
    }
}

public extension View {
    /// Installs presenter-backed Toast + Snackbar notifications once at app root.
    ///
    /// This is the preferred notification path for new code. Standalone
    /// `ToastState` and `SnackbarState` usage still works when you need local,
    /// explicit control.
    func installNotifications() -> some View {
        NotificationHost {
            self
        }
    }
}
