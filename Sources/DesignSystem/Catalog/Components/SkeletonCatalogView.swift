import SwiftUI

struct SkeletonCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Shimmer placeholder for loading states. Combine shapes to build full skeleton screens.")

                SectionCard(title: "Shapes") {
                    VStack(spacing: spacing.md) {
                        Skeleton().frame(height: 16)
                        Skeleton(.roundedRectangle(cornerRadius: 12)).frame(height: 120)
                        HStack(spacing: spacing.md) {
                            Skeleton(.circle).frame(width: 48, height: 48)
                            VStack(alignment: .leading, spacing: spacing.sm) {
                                Skeleton().frame(height: 14)
                                Skeleton().frame(width: 120, height: 12)
                            }
                        }
                    }
                }

                SectionCard(title: "Card Skeleton") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Skeleton(.roundedRectangle(cornerRadius: 12)).frame(height: 180)
                        Skeleton().frame(height: 18)
                        Skeleton().frame(height: 14)
                        Skeleton().frame(width: 160, height: 14)
                    }
                }

                CodeExample(code: """
                Skeleton().frame(height: 16)
                Skeleton(.circle).frame(width: 48, height: 48)
                
                // Shimmer on any view
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .shimmer()
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("Skeleton")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { SkeletonCatalogView().theme(ThemeProvider()) } }
