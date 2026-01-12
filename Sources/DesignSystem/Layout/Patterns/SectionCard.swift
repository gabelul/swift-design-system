import SwiftUI

/// Card Section with Title
///
/// A layout pattern combining a title with card-styled content.
/// Used in settings screens, catalog views, dashboards, and other scenarios where information needs to be grouped and displayed.
///
/// ## Usage Example
/// ```swift
/// @Environment(\.spacingScale) var spacing
///
/// ScrollView {
///     VStack(spacing: spacing.xl) {  // Section spacing: 24pt
///         SectionCard(title: "Basic Settings") {
///             VStack(spacing: spacing.md) {
///                 Toggle("Enable Notifications", isOn: $isNotificationEnabled)
///                 Toggle("Dark Mode", isOn: $isDarkMode)
///             }
///         }
///
///         SectionCard(title: "Profile", elevation: .level2) {
///             VStack(alignment: .leading) {
///                 Text("Name: John Doe")
///                 Text("Email: john@example.com")
///             }
///         }
///     }
///     // .padding(.horizontal) not needed - SectionCard manages it
/// }
/// ```
///
/// ## Spacing
/// - Title-Content spacing: `spacing.md` (12pt)
/// - Horizontal padding: `spacing.lg` (16pt) - automatically applied
///
/// ## Use Cases
/// - Sectioning in settings screens
/// - Dashboard widget placement
/// - Form grouping
/// - Item display in catalog views
public struct SectionCard<Content: View>: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    private let title: String
    private let content: Content
    private let elevation: Elevation

    /// Creates a card section with title
    /// - Parameters:
    ///   - title: Section title
    ///   - elevation: Card elevation level (default: .level1)
    ///   - content: Content to display inside the card
    public init(
        title: String,
        elevation: Elevation = .level1,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.elevation = elevation
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text(title)
                .typography(.titleMedium)
                .foregroundStyle(colorPalette.onSurface)

            Card(elevation: elevation) {
                content
            }
        }
        .padding(.horizontal, spacing.lg)
    }
}

#Preview {
    @Previewable @Environment(\.spacingScale) var spacing

    ScrollView {
        VStack(spacing: spacing.xl) {
            SectionCard(title: "Basic Information") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("Name: John Doe")
                        .typography(.bodyMedium)
                    Text("Email: john@example.com")
                        .typography(.bodyMedium)
                }
            }

            SectionCard(title: "Settings", elevation: .level2) {
                VStack(spacing: spacing.lg) {
                    HStack {
                        Text("Notifications")
                        Spacer()
                        Text("ON")
                            .foregroundStyle(.secondary)
                    }
                    .typography(.bodyMedium)

                    HStack {
                        Text("Dark Mode")
                        Spacer()
                        Text("OFF")
                            .foregroundStyle(.secondary)
                    }
                    .typography(.bodyMedium)
                }
            }
        }
        .padding(.vertical, spacing.xl)
    }
    .theme(ThemeProvider())
}
