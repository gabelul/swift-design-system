import SwiftUI

/// Expandable/collapsible section with header and content
///
/// Tap the header to toggle the content area open or closed.
/// Animated with the theme's motion tokens and respects reduce-motion.
///
/// ## Usage
/// ```swift
/// // Simple text header
/// Accordion("Advanced Settings") {
///     Toggle("Debug Mode", isOn: $debug)
///     Toggle("Verbose Logging", isOn: $verbose)
/// }
///
/// // Custom header
/// Accordion {
///     Label("Details", systemImage: "info.circle")
/// } content: {
///     Text("Expanded content here")
/// }
/// ```
public struct Accordion<Header: View, Content: View>: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius
    @Environment(\.motion) private var motion

    @State private var isExpanded: Bool
    private let header: Header
    private let content: Content

    /// Creates an accordion with custom header and content views
    ///
    /// - Parameters:
    ///   - isExpanded: Initial expanded state (default: false)
    ///   - header: The always-visible header view
    ///   - content: The collapsible content view
    public init(
        isExpanded: Bool = false,
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content
    ) {
        self._isExpanded = State(initialValue: isExpanded)
        self.header = header()
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Tappable header
            Button {
                withAnimation(motion.toggle) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    header
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(colors.onSurfaceVariant)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .animate(motion.toggle, value: isExpanded)
                }
                .padding(.horizontal, spacing.lg)
                .padding(.vertical, spacing.md)
            }
            .buttonStyle(.plain)

            // Collapsible content
            if isExpanded {
                content
                    .padding(.horizontal, spacing.lg)
                    .padding(.bottom, spacing.md)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: radius.md))
        .elevation(.level1)
    }
}

// MARK: - Convenience for text-only header

public extension Accordion where Header == AnyView {
    /// Creates an accordion with a text header
    ///
    /// - Parameters:
    ///   - title: Header text
    ///   - isExpanded: Initial expanded state (default: false)
    ///   - content: The collapsible content view
    init(
        _ title: String,
        isExpanded: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.init(isExpanded: isExpanded) {
            AnyView(
                Text(title)
                    .typography(.titleSmall)
            )
        } content: {
            content()
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        Accordion("Account Settings") {
            VStack(alignment: .leading, spacing: 8) {
                Text("Email: user@example.com")
                Text("Plan: Pro")
            }
        }

        Accordion("Notifications", isExpanded: true) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Push: Enabled")
                Text("Email: Disabled")
            }
        }
    }
    .padding()
    .theme(ThemeProvider())
}
