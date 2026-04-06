import SwiftUI

struct AvatarCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Circular avatar with image or initials fallback. Available in four sizes.")

                SectionCard(title: "Sizes") {
                    HStack(spacing: spacing.lg) {
                        VStack { Avatar(initials: "S", size: .small); Text("Small").typography(.labelSmall) }
                        VStack { Avatar(initials: "MD", size: .medium); Text("Medium").typography(.labelSmall) }
                        VStack { Avatar(initials: "LG", size: .large); Text("Large").typography(.labelSmall) }
                        VStack { Avatar(initials: "XL", size: .extraLarge); Text("Extra Large").typography(.labelSmall) }
                    }
                    .foregroundStyle(colors.onSurfaceVariant)
                }

                SectionCard(title: "With Badge") {
                    HStack(spacing: spacing.xl) {
                        Avatar(initials: "AB", size: .large).badge()
                        Avatar(initials: "CD", size: .large).badge(3)
                    }
                }

                CodeExample(code: """
                Avatar(initials: "JD", size: .medium)
                Avatar(image: Image("photo"), size: .large)
                Avatar(initials: "AB").badge(5)
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("Avatar")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { AvatarCatalogView().theme(ThemeProvider()) } }
