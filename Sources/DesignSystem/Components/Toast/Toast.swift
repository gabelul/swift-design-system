import SwiftUI

/// Lightweight auto-dismissing notification
///
/// Unlike Snackbar, Toast has no action buttons — it's a brief message
/// that appears at the top of the screen and disappears automatically.
/// Color and icon are driven by the `ToastLevel`.
///
/// ## Usage
/// ```swift
/// @State private var toastState = ToastState()
///
/// VStack {
///     Button("Save") {
///         save()
///         toastState.show(message: "Saved", level: .success)
///     }
/// }
/// .overlay(alignment: .top) {
///     Toast(state: toastState)
/// }
/// ```
public struct Toast: View {
    @Bindable public var state: ToastState
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    /// Creates a toast view bound to a state object
    ///
    /// - Parameter state: The ToastState managing visibility and content
    public init(state: ToastState) {
        self.state = state
    }

    public var body: some View {
        if state.isVisible {
            HStack(spacing: spacing.sm) {
                Image(systemName: state.icon ?? state.level.icon)
                    .font(.system(size: 16, weight: .semibold))

                Text(state.message)
                    .typography(.bodySmall)
                    .lineLimit(2)

                Spacer()

                Button {
                    withAnimation { state.dismiss() }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(foregroundColor.opacity(0.6))
                }
                .buttonStyle(.plain)
            }
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, spacing.lg)
            .padding(.vertical, spacing.md)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: radius.md))
            .padding(.horizontal, spacing.lg)
            .padding(.top, spacing.sm)
            .transition(.move(edge: .top).combined(with: .opacity))
            .animation(.spring(duration: 0.35, bounce: 0.2), value: state.isVisible)
        }
    }

    // MARK: - Level-based colors

    private var backgroundColor: Color {
        switch state.level {
        case .info: return colors.info.opacity(0.15)
        case .success: return colors.success.opacity(0.15)
        case .warning: return colors.warning.opacity(0.15)
        case .error: return colors.error.opacity(0.15)
        }
    }

    private var foregroundColor: Color {
        switch state.level {
        case .info: return colors.info
        case .success: return colors.success
        case .warning: return colors.warning
        case .error: return colors.error
        }
    }
}

#Preview {
    @Previewable @State var toastState = ToastState()

    VStack(spacing: 16) {
        Button("Show Success") { toastState.show(message: "Changes saved", level: .success) }
        Button("Show Error") { toastState.show(message: "Something went wrong", level: .error) }
        Button("Show Info") { toastState.show(message: "New update available", level: .info) }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay(alignment: .top) {
        Toast(state: toastState)
    }
    .theme(ThemeProvider())
}
