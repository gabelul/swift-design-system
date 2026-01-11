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
<<<<<<< HEAD
                        NavigationLink {
                            AspectGridCatalogView()
                        } label: {
                            HStack(spacing: spacing.md) {
                                Image(systemName: "square.grid.2x2.fill")
                                    .font(.title3)
                                    .foregroundStyle(colorPalette.primary)
                                    .frame(width: 32)

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("AspectGrid")
                                        .typography(.bodyLarge)
                                        .foregroundStyle(colorPalette.onSurface)

                                    Text("Grid layout with fixed aspect ratio.")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colorPalette.onSurfaceVariant)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
=======
                        ForEach(PatternItem.allCases) { pattern in
                            NavigationLink {
                                destinationView(for: pattern)
                            } label: {
                                CatalogItemRowContent(
                                    icon: pattern.icon,
                                    title: pattern.rawValue,
                                    description: pattern.description
                                )
>>>>>>> upstream/main
                            }
                            .buttonStyle(.plain)
                        }
<<<<<<< HEAD
                        .buttonStyle(.plain)

                        NavigationLink {
                            SectionCardCatalogView()
                        } label: {
                            HStack(spacing: spacing.md) {
                                Image(systemName: "rectangle.fill.on.rectangle.fill")
                                    .font(.title3)
                                    .foregroundStyle(colorPalette.primary)
                                    .frame(width: 32)

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("SectionCard")
                                        .typography(.bodyLarge)
                                        .foregroundStyle(colorPalette.onSurface)

                                    Text("Section container with a title.")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colorPalette.onSurfaceVariant)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }
                            .padding(.horizontal, spacing.lg)
                            .padding(.vertical, spacing.md)
                            .background(colorPalette.surface)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
=======
>>>>>>> upstream/main
                    }
                    .padding(.horizontal, spacing.lg)
                }
            }
            .padding(.bottom, spacing.xl)
        }
<<<<<<< HEAD
        .background(colorPalette.background)
        .navigationTitle("Patterns")
=======
        .background(colors.background)
        .navigationTitle("パターン")
>>>>>>> upstream/main
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    @ViewBuilder
    private func destinationView(for pattern: PatternItem) -> some View {
        switch pattern {
        case .aspectGrid:
            AspectGridCatalogView()
        case .sectionCard:
            SectionCardCatalogView()
        }
    }
}

#Preview {
    NavigationStack {
        PatternsCatalogView()
            .theme(ThemeProvider())
    }
}
