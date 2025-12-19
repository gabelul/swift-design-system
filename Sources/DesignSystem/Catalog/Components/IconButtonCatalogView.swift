import SwiftUI

/// IconButton component catalog view
struct IconButtonCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing
    @State private var favoriteCount = 0
    @State private var likeCount = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Overview
                VStack(alignment: .leading, spacing: 12) {
                    Text("Icon buttons are compact action buttons composed only of an icon.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)

                    if favoriteCount > 0 || likeCount > 0 {
                        VStack(alignment: .leading, spacing: 4) {
                            if favoriteCount > 0 {
                                Text("お気に入り: \(favoriteCount)")
                                    .typography(.bodySmall)
                            }
                            if likeCount > 0 {
                                Text("いいね: \(likeCount)")
                                    .typography(.bodySmall)
                            }
                        }
                        .foregroundStyle(colorPalette.primary)
                    }
                }
                .padding(.horizontal, spacing.lg)
                .padding(.top, spacing.lg)

                // Style variants
                SectionCard(title: "Style Variants") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Four styles are available.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.lg) {
                            HStack {
                                Text("Standard")
                                    .typography(.bodyMedium)
                                    .frame(width: 120, alignment: .leading)

                                IconButton(icon: "heart", style: .standard) {
                                    favoriteCount += 1
                                }

                                Text("No background")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }

                            HStack {
                                Text("Filled")
                                    .typography(.bodyMedium)
                                    .frame(width: 120, alignment: .leading)

                                IconButton(icon: "heart.fill", style: .filled) {
                                    favoriteCount += 1
                                }

                                Text("Primary background")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }

                            HStack {
                                Text("Tonal")
                                    .typography(.bodyMedium)
                                    .frame(width: 120, alignment: .leading)

                                IconButton(icon: "heart.fill", style: .tonal) {
                                    favoriteCount += 1
                                }

                                Text("トーン背景")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }

                            HStack {
                                Text("Outlined")
                                    .typography(.bodyMedium)
                                    .frame(width: 120, alignment: .leading)

                                IconButton(icon: "heart", style: .outlined) {
                                    favoriteCount += 1
                                }

                                Text("枠線のみ")
                                    .typography(.labelSmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)
                            }
                        }
                    }
                }

                // Size variants
                SectionCard(title: "Size Variants") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Three sizes are available.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.lg) {
                            HStack {
                                Text("Small (32pt)")
                                    .typography(.bodyMedium)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                IconButton(icon: "star.fill", style: .filled, size: .small) {
                                    likeCount += 1
                                }
                            }

                            HStack {
                                Text("Medium (40pt)")
                                    .typography(.bodyMedium)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                IconButton(icon: "star.fill", style: .filled, size: .medium) {
                                    likeCount += 1
                                }
                            }

                            HStack {
                                Text("Large (48pt)")
                                    .typography(.bodyMedium)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                IconButton(icon: "star.fill", style: .filled, size: .large) {
                                    likeCount += 1
                                }
                            }
                        }
                    }
                }

                // Icon variants
                SectionCard(title: "Icon Variants") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Examples of frequently used icons.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        HStack(spacing: spacing.lg) {
                            IconButton(icon: "heart", style: .tonal) {
                                favoriteCount += 1
                            }

                            IconButton(icon: "star", style: .tonal) {
                                likeCount += 1
                            }

                            IconButton(icon: "bookmark", style: .tonal) {}

                            IconButton(icon: "square.and.arrow.up", style: .tonal) {}

                            IconButton(icon: "ellipsis", style: .tonal) {}
                        }
                        .frame(maxWidth: .infinity)
                    }
                }

                // Usage
                SectionCard(title: "Usage") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How to use in SwiftUI")
                            .typography(.titleSmall)

                        Text("""
                        IconButton(
                            icon: "heart",
                            style: .filled,
                            size: .medium
                        ) {
                            // アクション
                        }
                        """)
                        .typography(.bodySmall)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(colorPalette.surfaceVariant.opacity(0.5))
                        .cornerRadius(8)
                    }
                }

                // Practical example
                SectionCard(title: "Practical Example") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Example usage in a toolbar.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        Card {
                            VStack(spacing: spacing.md) {
                                HStack {
                                Text("Article Title")
                                        .typography(.titleMedium)
                                    Spacer()
                                }

                                Text("Preview body text. Icon buttons provide clear actions in a compact space.")
                                    .typography(.bodySmall)
                                    .foregroundStyle(colorPalette.onSurfaceVariant)

                                HStack {
                                    IconButton(icon: "heart", style: .tonal) {
                                        favoriteCount += 1
                                    }

                                    IconButton(icon: "bookmark", style: .tonal) {}

                                    IconButton(icon: "square.and.arrow.up", style: .tonal) {}

                                    Spacer()

                                    IconButton(icon: "ellipsis", style: .tonal) {}
                                }
                            }
                        }
                    }
                }
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("IconButton")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        IconButtonCatalogView()
            .theme(ThemeProvider())
    }
}
