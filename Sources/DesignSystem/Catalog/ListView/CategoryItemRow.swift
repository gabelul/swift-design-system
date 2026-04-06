import SwiftUI

/// Category item row view
struct CategoryItemRow: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    let category: CatalogCategory

    var body: some View {
        NavigationLink {
            CatalogRouter.destination(for: category)
        } label: {
            HStack(spacing: spacing.md) {
                Image(systemName: category.icon)
                    .font(.title3)
                    .foregroundStyle(colors.primary)
                    .frame(width: 32)

                VStack(alignment: .leading, spacing: 2) {
                    Text(category.rawValue)
                        .typography(.bodyLarge)
                        .foregroundStyle(colors.onSurface)

                    Text(category.description)
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .typography(.labelMedium)
                    .foregroundStyle(colors.onSurfaceVariant)
            }
            .padding(.horizontal, spacing.md)
            .padding(.vertical, spacing.md)
            .background(colors.background)
            .clipShape(RoundedRectangle(cornerRadius: radius.md))
        }
        .buttonStyle(.plain)
    }
}
