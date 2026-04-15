import SwiftUI

/// A single row inside a `SectionCard`.
///
/// An HStack with unified horizontal / vertical padding. Used as the label
/// of a Button or NavigationLink to keep a consistent look across card-style
/// list rows. Because `contentShape(Rectangle())` is applied, taps on the
/// padding area register too — no dead zones on the edges.
///
/// ## Usage
/// ```swift
/// SectionRow {
///     Label("Notifications", systemImage: "bell")
///     Spacer(minLength: 0)
///     Toggle("", isOn: $isOn).labelsHidden()
/// }
/// ```
public struct SectionRow<Content: View>: View {
    @Environment(\.spacingScale) private var spacing

    private let content: () -> Content

    /// Creates a single row for use inside a section card.
    /// - Parameter content: The row contents, laid out left-to-right like an HStack.
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        HStack(spacing: spacing.md) {
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, spacing.lg)
        .padding(.vertical, spacing.md)
        .contentShape(Rectangle())
    }
}
