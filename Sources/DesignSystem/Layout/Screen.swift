import SwiftUI

/// A scrollable page wrapper with standard padding and background
///
/// Provides the common boilerplate every screen needs: a ScrollView,
/// consistent padding from design tokens, the theme background color,
/// and an optional navigation title.
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
/// ## Without a title
/// ```swift
/// Screen {
///     Text("Content goes here")
/// }
/// ```
public struct Screen<Content: View>: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    private let title: String?
    private let content: Content

    /// Creates a screen with an optional navigation title
    ///
    /// - Parameters:
    ///   - title: Navigation bar title (omit for untitled screens)
    ///   - content: The screen's content
    public init(
        _ title: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }

    public var body: some View {
        ScrollView {
            content
                .padding(.horizontal, spacing.lg)
                .padding(.vertical, spacing.xl)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorPalette.background)
        .if(title != nil) { view in
            view
                .navigationTitle(title!)
                #if os(iOS)
                .navigationBarTitleDisplayMode(.large)
                #endif
        }
    }
}

// MARK: - Conditional Modifier Helper

private extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
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
