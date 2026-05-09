import SwiftUI

/// Screen scrolling behavior.
public enum ScreenScrollBehavior: Sendable {
    /// Wrap content in a vertical `ScrollView`.
    case scrolls

    /// Render content directly with no outer scroll container.
    case fixed
}

/// Screen padding preset.
public enum ScreenPadding: Sendable {
    /// Default page padding: horizontal `spacing.lg`, vertical `spacing.xl`.
    case standard

    /// Denser page padding: horizontal `spacing.lg`, vertical `spacing.lg`.
    case compact

    /// Remove page padding entirely.
    case none

    /// Provide explicit page padding.
    case custom(horizontal: CGFloat, vertical: CGFloat)

    fileprivate func horizontalPadding(spacing: any SpacingScale) -> CGFloat {
        switch self {
        case .standard, .compact:
            return spacing.lg
        case .none:
            return 0
        case let .custom(horizontal, _):
            return horizontal
        }
    }

    fileprivate func verticalPadding(spacing: any SpacingScale) -> CGFloat {
        switch self {
        case .standard:
            return spacing.xl
        case .compact:
            return spacing.lg
        case .none:
            return 0
        case let .custom(_, vertical):
            return vertical
        }
    }
}

/// Navigation title display mode for `Screen`.
public enum ScreenTitleDisplayMode: Sendable {
    /// Use platform defaults.
    case automatic

    /// Prefer a large navigation title on iOS.
    case large

    /// Prefer an inline navigation title on iOS.
    case inline
}

/// A page wrapper with consistent padding, background, and optional scrolling.
///
/// Provides the common boilerplate every screen needs: optional vertical scrolling,
/// consistent padding from design tokens, the theme background color, and an optional navigation title.
///
/// ## Usage
/// ```swift
/// Screen("Settings") {
///     VStack(spacing: spacing.lg) {
///         SectionCard("Account") {
///             Text("Profile settings")
///         }
///         SectionCard("Preferences") {
///             Text("App preferences")
///         }
///     }
/// }
/// ```
///
/// ## Compact parity pass
/// ```swift
/// Screen(
///     "Welcome",
///     padding: .compact,
///     titleDisplayMode: .inline
/// ) {
///     content
/// }
/// ```
///
/// ## Without outer scrolling
/// ```swift
/// Screen("Editor", scrollBehavior: .fixed) {
///     customScrollBody
/// }
/// ```
public struct Screen<Content: View>: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    private let title: String?
    private let scrollBehavior: ScreenScrollBehavior
    private let padding: ScreenPadding
    private let titleDisplayMode: ScreenTitleDisplayMode
    private let content: Content

    /// Creates a screen with optional navigation title and layout controls.
    ///
    /// - Parameters:
    ///   - title: Navigation bar title (omit for untitled screens)
    ///   - scrollBehavior: Whether `Screen` should provide the outer vertical scroll container.
    ///   - padding: Page padding preset.
    ///   - titleDisplayMode: Preferred navigation title presentation.
    ///   - content: The screen's content.
    public init(
        _ title: String? = nil,
        scrollBehavior: ScreenScrollBehavior = .scrolls,
        padding: ScreenPadding = .standard,
        titleDisplayMode: ScreenTitleDisplayMode = .large,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.scrollBehavior = scrollBehavior
        self.padding = padding
        self.titleDisplayMode = titleDisplayMode
        self.content = content()
    }

    public var body: some View {
        screenBody
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(colorPalette.background)
            .applyNavigationTitle(title, displayMode: titleDisplayMode)
    }

    @ViewBuilder
    private var screenBody: some View {
        switch scrollBehavior {
        case .scrolls:
            ScrollView {
                paddedContent
            }
        case .fixed:
            paddedContent
        }
    }

    private var paddedContent: some View {
        content
            .padding(.horizontal, padding.horizontalPadding(spacing: spacing))
            .padding(.vertical, padding.verticalPadding(spacing: spacing))
    }
}

private extension View {
    @ViewBuilder
    func applyNavigationTitle(
        _ title: String?,
        displayMode: ScreenTitleDisplayMode
    ) -> some View {
        if let title {
            let view = navigationTitle(title)
            #if os(iOS)
            switch displayMode {
            case .automatic:
                view
            case .large:
                view.navigationBarTitleDisplayMode(.large)
            case .inline:
                view.navigationBarTitleDisplayMode(.inline)
            }
            #else
            view
            #endif
        } else {
            self
        }
    }
}

#Preview {
    NavigationStack {
        Screen("Demo Screen") {
            VStack(spacing: 16) {
                Card {
                    Text("First card")
                }
                Card {
                    Text("Second card")
                }
            }
        }
    }
    .theme(ThemeProvider())
}
