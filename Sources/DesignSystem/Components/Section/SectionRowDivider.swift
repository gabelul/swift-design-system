import SwiftUI

/// A 0.5pt hairline divider inserted between rows inside a `SectionCard`.
///
/// Uses the `outlineVariant` color (a semi-transparent outline tone) so it
/// sits quietly on the card's surface. A leading inset of `spacing.lg` keeps
/// the separator visually balanced with the standard iOS List separator style.
///
/// ## Usage
/// ```swift
/// SectionCard("Settings") {
///     SectionRow { Text("Item 1") }
///     SectionRowDivider()
///     SectionRow { Text("Item 2") }
/// }
/// ```
public struct SectionRowDivider: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    public init() {}

    public var body: some View {
        Rectangle()
            .fill(colors.outlineVariant)
            .frame(height: 0.5)
            .padding(.leading, spacing.lg)
    }
}
