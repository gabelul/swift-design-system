import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

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

    /// Gesture offset used for swipe-to-dismiss.
    @State private var dragOffset: CGSize = .zero

    /// Creates a toast view bound to a state object
    ///
    /// - Parameter state: The ToastState managing visibility and content
    public init(state: ToastState) {
        self.state = state
    }

    public var body: some View {
        GeometryReader { proxy in
            if state.isVisible {
                toastBody
                    .padding(.horizontal, spacing.lg)
                    .padding(.top, topInset(for: proxy) + spacing.sm)
                    .offset(x: dragOffset.width, y: min(0, dragOffset.height))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .gesture(dismissGesture)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.spring(duration: 0.35, bounce: 0.2), value: state.isVisible)
            }
        }
        .ignoresSafeArea(edges: .top)
        .onChange(of: state.isVisible) { _, isVisible in
            if !isVisible {
                dragOffset = .zero
            }
        }
    }

    private var toastBody: some View {
        // An OPAQUE card with a shadow, not a 15%-opacity tint. The old tint
        // dissolved into whatever was behind it — over a screen that puts its own
        // header at the top (no nav bar), the toast read as barely-there smudge on
        // the header text. An elevated surface + a level-colored icon and edge +
        // dark, legible text reads as a distinct banner floating above content, and
        // matches the app's Card styling.
        HStack(spacing: spacing.sm) {
            Image(systemName: state.icon ?? state.level.icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(accentColor)

            Text(state.message)
                .typography(.bodySmall)
                .foregroundStyle(colors.onSurface)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: spacing.sm)

            Button {
                withAnimation { state.dismiss() }
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(colors.onSurfaceVariant)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, spacing.lg)
        .padding(.vertical, spacing.md)
        .background(colors.elevatedSurface)
        .overlay(
            RoundedRectangle(cornerRadius: radius.md)
                .strokeBorder(accentColor.opacity(0.3), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: radius.md))
        .elevation(.level3)
    }

    // MARK: - Level-based colors

    /// The level's signal color — used for the icon and a subtle edge, so the
    /// banner reads as info / success / warning / error without tinting the whole
    /// surface (which is what made the old toast illegible).
    private var accentColor: Color {
        switch state.level {
        case .info: return colors.info
        case .success: return colors.success
        case .warning: return colors.warning
        case .error: return colors.error
        }
    }

    private func topInset(for proxy: GeometryProxy) -> CGFloat {
        #if canImport(UIKit)
        let sceneInset = UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow?.safeAreaInsets.top }
            .max() ?? 0
        return max(proxy.safeAreaInsets.top, sceneInset)
        #else
        return proxy.safeAreaInsets.top
        #endif
    }

    /// Supports dismissing the toast with an upward or strong horizontal swipe.
    private var dismissGesture: some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                dragOffset = CGSize(
                    width: value.translation.width,
                    height: min(0, value.translation.height)
                )
            }
            .onEnded { value in
                let shouldDismiss = value.translation.height < -24 || abs(value.translation.width) > 80
                withAnimation {
                    if shouldDismiss {
                        state.dismiss()
                    }
                    dragOffset = .zero
                }
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
