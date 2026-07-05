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
    /// Follow the nearest installed `ScreenDensity` environment value.
    case automatic

    /// Default page padding: horizontal `spacing.lg`, vertical `spacing.xl`.
    case standard

    /// Denser page padding: horizontal `spacing.lg`, vertical `spacing.lg`.
    case compact

    /// More generous page padding: horizontal `spacing.xl`, vertical `spacing.xxl`.
    case spacious

    /// Remove page padding entirely.
    case none

    /// Provide explicit page padding.
    case custom(horizontal: CGFloat, vertical: CGFloat)

    func resolvedHorizontalPadding(
        spacing: any SpacingScale,
        density: ScreenDensity
    ) -> CGFloat {
        switch resolvedPadding(for: density) {
        case .automatic:
            return spacing.lg
        case .standard, .compact:
            return spacing.lg
        case .spacious:
            return spacing.xl
        case .none:
            return 0
        case let .custom(horizontal, _):
            return horizontal
        }
    }

    func resolvedVerticalPadding(
        spacing: any SpacingScale,
        density: ScreenDensity
    ) -> CGFloat {
        switch resolvedPadding(for: density) {
        case .automatic:
            return spacing.xl
        case .standard:
            return spacing.xl
        case .compact:
            return spacing.lg
        case .spacious:
            return spacing.xxl
        case .none:
            return 0
        case let .custom(_, vertical):
            return vertical
        }
    }

    private func resolvedPadding(for density: ScreenDensity) -> ScreenPadding {
        switch self {
        case .automatic:
            switch density {
            case .compact: return .compact
            case .standard: return .standard
            case .spacious: return .spacious
            }
        default:
            return self
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
/// ## Brand-driven density
/// ```swift
/// ContentView()
///     .screenDensity(.spacious)
///
/// Screen("Onboarding", padding: .automatic) {
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
    @Environment(\.screenDensity) private var screenDensity

    private let title: String?
    private let scrollBehavior: ScreenScrollBehavior
    private let padding: ScreenPadding
    private let titleDisplayMode: ScreenTitleDisplayMode
    private let bottomInset: AnyView?
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
        padding: ScreenPadding = .automatic,
        titleDisplayMode: ScreenTitleDisplayMode = .large,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.scrollBehavior = scrollBehavior
        self.padding = padding
        self.titleDisplayMode = titleDisplayMode
        self.bottomInset = nil
        self.content = content()
    }

    /// Creates a screen with a pinned bottom inset owned by the page shell.
    ///
    /// Use this overload when the screen has a required bottom action such as
    /// a primary CTA. The inset is attached to the `Screen`'s own scroll
    /// container so long content stops above the pinned footer instead of
    /// scrolling behind it.
    ///
    /// - Parameters:
    ///   - title: Navigation bar title (omit for untitled screens)
    ///   - scrollBehavior: Whether `Screen` should provide the outer vertical scroll container.
    ///   - padding: Page padding preset.
    ///   - titleDisplayMode: Preferred navigation title presentation.
    ///   - bottomInset: Footer content pinned to the bottom edge of the page shell.
    ///   - content: The screen's content.
    public init<BottomInset: View>(
        _ title: String? = nil,
        scrollBehavior: ScreenScrollBehavior = .scrolls,
        padding: ScreenPadding = .automatic,
        titleDisplayMode: ScreenTitleDisplayMode = .large,
        @ViewBuilder bottomInset: () -> BottomInset,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.scrollBehavior = scrollBehavior
        self.padding = padding
        self.titleDisplayMode = titleDisplayMode
        self.bottomInset = AnyView(bottomInset())
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
            scrollViewBody
        case .fixed:
            fixedBody
        }
    }

    @ViewBuilder
    private var scrollViewBody: some View {
        if let bottomInset {
            ScrollView {
                paddedContent
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                bottomInset
            }
        } else {
            ScrollView {
                paddedContent
            }
        }
    }

    @ViewBuilder
    private var fixedBody: some View {
        if let bottomInset {
            paddedContent
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    bottomInset
                }
        } else {
            paddedContent
        }
    }

    private var paddedContent: some View {
        content
            .padding(.horizontal, padding.resolvedHorizontalPadding(spacing: spacing, density: screenDensity))
            .padding(.vertical, padding.resolvedVerticalPadding(spacing: spacing, density: screenDensity))
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
            #if os(iOS)
            switch displayMode {
            case .inline:
                // Honor an explicit inline request even with no title. Without
                // this, iOS falls back to its default .large mode and reserves
                // empty large-title space — a phantom top gap that shows up once
                // the screen adds a .principal toolbar item. Untitled screens
                // using .large/.automatic keep the platform default so existing
                // layouts don't shift.
                navigationBarTitleDisplayMode(.inline)
            case .large, .automatic:
                self
            }
            #else
            self
            #endif
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
