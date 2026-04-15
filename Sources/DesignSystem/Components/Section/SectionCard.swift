import SwiftUI

/// A rounded surface card for Section-style groupings — the backbone of
/// settings screens, hub screens, and dashboard layouts.
///
/// Reproduces the visual hierarchy of `List { Section { ... } }` using only
/// design system tokens (surface / spacing / typography / radius) so it fits
/// anywhere a List can't (inside ScrollView, custom layouts, etc.).
///
/// ## Two ways to use it
///
/// ### 1. Surface Section (new API, recommended)
/// Small uppercase header + rounded surface card + optional footer caption.
/// Stack `SectionRow` vertically inside, separated by `SectionRowDivider` when needed.
///
/// ```swift
/// SectionCard("Notifications", footer: "Manage system-level notifications in Settings") {
///     SectionRow {
///         Text("Morning reminder")
///         Spacer(minLength: 0)
///         Toggle("", isOn: $isOn).labelsHidden()
///     }
///     SectionRowDivider()
///     NavigationLink(destination: DetailView()) {
///         SectionNavigationLabel("Advanced", systemImage: "gear")
///     }
/// }
/// ```
///
/// ### 2. Titled Card (legacy API, kept for backwards compatibility)
/// Title + generic `Card`-wrapped container. Good for free-form layouts
/// like forms and dashboards where rows aren't the right shape.
///
/// ```swift
/// SectionCard(title: "Profile", elevation: .level2) {
///     VStack(alignment: .leading) {
///         Text("Name: John Doe")
///         Text("Email: john@example.com")
///     }
/// }
/// ```
public struct SectionCard<Content: View>: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    private let style: Style
    private let content: () -> Content

    private enum Style {
        case surface(header: String?, footer: String?)
        case titled(title: String, elevation: Elevation)
    }

    /// Surface Section style (new API).
    ///
    /// - Parameters:
    ///   - header: Outer header label above the card (rendered uppercase, pass `nil` to hide).
    ///   - footer: Outer footer caption below the card.
    ///   - content: Card contents. Typically a vertical stack of `SectionRow`.
    public init(
        _ header: String? = nil,
        footer: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.style = .surface(header: header, footer: footer)
        self.content = content
    }

    /// Titled Card style (legacy API, kept for backwards compatibility).
    ///
    /// - Parameters:
    ///   - title: Section title.
    ///   - elevation: Card elevation level (default `.level1`).
    ///   - content: Content to display inside the card.
    public init(
        title: String,
        elevation: Elevation = .level1,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.style = .titled(title: title, elevation: elevation)
        self.content = content
    }

    public var body: some View {
        switch style {
        case let .surface(header, footer):
            VStack(alignment: .leading, spacing: spacing.xs) {
                if let header {
                    Text(header)
                        .typography(.labelSmall)
                        .foregroundStyle(colors.onSurfaceVariant)
                        .textCase(.uppercase)
                        .padding(.horizontal, spacing.md)
                }

                VStack(spacing: 0) {
                    content()
                }
                .background(colors.surface)
                .clipShape(RoundedRectangle(cornerRadius: radius.lg))

                if let footer {
                    Text(footer)
                        .typography(.labelSmall)
                        .foregroundStyle(colors.onSurfaceVariant)
                        .padding(.horizontal, spacing.md)
                }
            }

        case let .titled(title, elevation):
            VStack(alignment: .leading, spacing: spacing.md) {
                Text(title)
                    .typography(.titleMedium)
                    .foregroundStyle(colors.onSurface)

                Card(elevation: elevation) {
                    content()
                }
            }
            .padding(.horizontal, spacing.lg)
        }
    }
}

#Preview("Surface Section") {
    @Previewable @Environment(\.spacingScale) var spacing

    ScrollView {
        VStack(spacing: spacing.xl) {
            SectionCard("Notifications", footer: "Manage system-level notifications in Settings") {
                SectionRow {
                    Text("Morning reminder")
                    Spacer(minLength: 0)
                    Text("ON").foregroundStyle(.secondary)
                }
                SectionRowDivider()
                SectionRow {
                    SectionNavigationLabel("Advanced settings", systemImage: "gear")
                }
            }

            SectionCard("Account") {
                SectionRow {
                    Text("Email")
                    Spacer(minLength: 0)
                    Text("user@example.com").foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, spacing.xl)
    }
    .theme(ThemeProvider())
}

#Preview("Titled Card") {
    @Previewable @Environment(\.spacingScale) var spacing

    ScrollView {
        VStack(spacing: spacing.xl) {
            SectionCard(title: "Basic information") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("Name: John Doe").typography(.bodyMedium)
                    Text("Email: john@example.com").typography(.bodyMedium)
                }
            }
        }
        .padding(.vertical, spacing.xl)
    }
    .theme(ThemeProvider())
}
