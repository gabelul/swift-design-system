import SwiftUI

/// Entry point for the patterns catalog
/// Shows layout and design patterns
struct PatternsCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(spacing: spacing.xl) {
                // Header
                VStack(spacing: spacing.sm) {
                    Image(systemName: "square.grid.3x3.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(colors.primary)

                    Text("Patterns Catalog")
                        .typography(.headlineLarge)
                        .foregroundStyle(colors.onBackground)

                    Text("Layout and design patterns")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, spacing.xl)

                // Pattern list
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("Layout Patterns")
                        .typography(.titleMedium)
                        .foregroundStyle(colors.onSurface)
                        .padding(.horizontal, spacing.lg)

                    VStack(spacing: spacing.sm) {
                        ForEach(PatternItem.allCases) { pattern in
                            NavigationLink {
                                destinationView(for: pattern)
                            } label: {
                                CatalogItemRowContent(
                                    icon: pattern.icon,
                                    title: pattern.rawValue,
                                    description: pattern.description
                                )
