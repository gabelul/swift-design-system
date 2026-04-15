import SwiftUI

/// A navigation row label with a trailing chevron.
///
/// Designed for use as the label of a `NavigationLink`, e.g.
/// `NavigationLink { ... } label: { SectionNavigationLabel("Title") }`.
/// It wraps its content in a `SectionRow`, so it drops straight into a
/// `SectionCard` without extra layout work.
///
/// ## Usage
/// ```swift
/// SectionCard("Settings") {
///     NavigationLink {
///         NotificationSettingsView()
///     } label: {
///         SectionNavigationLabel("Notification details", systemImage: "bell.badge")
///     }
/// }
/// ```
public struct SectionNavigationLabel: View {
    @Environment(\.colorPalette) private var colors

    private let title: String
    private let systemImage: String?

    /// Creates a navigation label with a trailing chevron.
    /// - Parameters:
    ///   - title: The label text.
    ///   - systemImage: Optional SF Symbols name to display on the leading side.
    public init(_ title: String, systemImage: String? = nil) {
        self.title = title
        self.systemImage = systemImage
    }

    public var body: some View {
        SectionRow {
            if let systemImage {
                Label(title, systemImage: systemImage)
                    .foregroundStyle(colors.onSurface)
            } else {
                Text(title)
                    .foregroundStyle(colors.onSurface)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .typography(.labelSmall)
                .foregroundStyle(colors.onSurfaceVariant)
        }
    }
}
