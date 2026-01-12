import SwiftUI

/// Snackbar (Temporary Notification UI)
///
/// A temporary notification UI that appears from the bottom of the screen.
/// Displays feedback for user actions or simple notifications.
///
/// ## Basic Usage
/// ```swift
/// @State private var snackbarState = SnackbarState()
///
/// var body: some View {
///     ZStack {
///         ContentView()
///
///         Snackbar(state: snackbarState)
///     }
///     .onAppear {
///         snackbarState.show(message: "Saved successfully")
///     }
/// }
/// ```
///
/// ## Snackbar with Actions
/// ```swift
/// snackbarState.show(
///     message: "Deleted successfully",
///     primaryAction: SnackbarAction(title: "Undo") {
///         // Undo processing
///     },
///     secondaryAction: SnackbarAction(title: "Close") {
///         snackbarState.dismiss()
///     }
/// )
/// ```
///
/// ## Design Guidelines
/// - Keep messages concise (1-2 lines)
/// - Maximum of 2 actions
/// - Recommended auto-dismiss time is 3-7 seconds
/// - Allow sufficient time for important operations
public struct Snackbar: View {
    @Bindable public var state: SnackbarState
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    public init(state: SnackbarState) {
        self._state = Bindable(state)
    }

    public var body: some View {
        VStack {
            Spacer()

            if state.isVisible {
                HStack(spacing: spacing.md) {
                    // Message
                    Text(state.message)
                        .typography(.bodyLarge)
                        .foregroundStyle(colors.onSurface)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer(minLength: spacing.sm)

                    // Action buttons
                    HStack(spacing: spacing.sm) {
                        if let primary = state.primaryAction {
                            Button {
                                Task {
                                    await primary.action()
                                }
                                state.dismiss()
                            } label: {
                                Text(primary.title)
                                    .typography(.labelLarge)
                                    .foregroundStyle(colors.primary)
                            }
                            .buttonStyle(.borderless)
                        }

                        if let secondary = state.secondaryAction {
                            Button {
                                Task {
                                    await secondary.action()
                                }
                                state.dismiss()
                            } label: {
                                Text(secondary.title)
                                    .typography(.labelLarge)
                                    .foregroundStyle(colors.error)
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
                .padding(.horizontal, spacing.lg)
                .padding(.vertical, spacing.md)
                .background(colors.surfaceVariant)
                .clipShape(RoundedRectangle(cornerRadius: radius.md))
                .elevation(.level2)
                .padding(.horizontal, spacing.lg)
                .padding(.bottom, spacing.lg)
                .transition(.asymmetric(
                    insertion: .move(edge: .bottom).combined(with: .opacity),
                    removal: .move(edge: .bottom).combined(with: .opacity)
                ))
                .accessibilityElement(children: .contain)
                .accessibilityLabel(state.message)
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: state.isVisible)
    }
}
