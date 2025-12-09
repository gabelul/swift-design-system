import SwiftUI

/// Entry point for the patterns catalog
/// Shows layout and design patterns
struct PatternsCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(spacing: spacing.xl) {
                // Header
                VStack(spacing: spacing.sm) {
                    Image(systemName: "square.grid.3x3.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(colorPalette.primary)

                    Text("Patterns Catalog")
                        .typography(.headlineLarge)
                        .foregroundStyle(colorPalette.onBackground)

                    Text("Layout and design patterns")
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, spacing.xl)

                // Pattern list
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("Layout Patterns")
                        .typography(.titleMedium)
                        .foregroundStyle(colorPalette.onSurface)
                        .padding(.horizontal, spacing.lg)

                    VStack(spacing: spacing.sm) {
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
                            }
                            .padding(.horizontal, spacing.lg)
                            .padding(.vertical, spacing.md)
                            .background(colorPalette.surface)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
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
                    }
                    .padding(.horizontal, spacing.lg)
                }
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("Patterns")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        PatternsCatalogView()
            .theme(ThemeProvider())
    }
}
