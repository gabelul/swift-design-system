import SwiftUI

/// FAB component catalog view
struct FloatingActionButtonCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius
    @State private var tapCount = 0

    var body: some View {
<<<<<<< HEAD
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Overview
                VStack(alignment: .leading, spacing: 12) {
                    Text("The Floating Action Button (FAB) represents the most important action on a screen.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)

                    if tapCount > 0 {
                        Text("Tap count: \(tapCount)")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.primary)
                    }
                }
                .padding(.horizontal, spacing.lg)
                .padding(.top, spacing.lg)

                // Size variants
                SectionCard(title: "Size Variants") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Three sizes are available.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.lg) {
                            HStack {
                                Text("Small (40pt)")
                                    .typography(.bodyMedium)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                FloatingActionButton(icon: "plus", size: .small) {
                                    tapCount += 1
                                }
                            }

                            HStack {
                                Text("Regular (56pt)")
                                    .typography(.bodyMedium)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                FloatingActionButton(icon: "plus", size: .regular) {
                                    tapCount += 1
                                }
                            }

                            HStack {
                                Text("Large (96pt)")
                                    .typography(.bodyMedium)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                FloatingActionButton(icon: "plus", size: .large) {
                                    tapCount += 1
                                }
                            }
                        }
                    }
                }

                // Icon variants
                SectionCard(title: "Icon Variants") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Supports SF Symbols icons.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        HStack(spacing: spacing.lg) {
                            FloatingActionButton(icon: "plus") {
                                tapCount += 1
                            }

                            FloatingActionButton(icon: "pencil") {
                                tapCount += 1
                            }

                            FloatingActionButton(icon: "camera") {
                                tapCount += 1
                            }

                            FloatingActionButton(icon: "trash") {
                                tapCount += 1
                            }
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
                        FloatingActionButton(
                            icon: "plus",
                            size: .regular
                        ) {
                            // アクション
                        }
                        """)
=======
        CatalogPageContainer(title: "FAB") {
            VStack(alignment: .leading, spacing: spacing.sm) {
                CatalogOverview(description: "画面上で最も重要なアクションを表すボタン")

                if tapCount > 0 {
                    Text("タップ回数: \(tapCount)")
>>>>>>> upstream/main
                        .typography(.bodySmall)
                        .foregroundStyle(colors.primary)
                        .padding(.horizontal, spacing.lg)
                }
            }

<<<<<<< HEAD
                // Layout example
                SectionCard(title: "Layout Example") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Typical pattern: placing the FAB at the bottom-right corner.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        ZStack(alignment: .bottomTrailing) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colorPalette.surfaceVariant.opacity(0.3))
                                .frame(height: 200)

                            FloatingActionButton(icon: "plus") {
                                tapCount += 1
                            }
                            .padding(16)
                        }
=======
            SectionCard(title: "サイズ") {
                VStack(spacing: spacing.lg) {
                    HStack {
                        Text("Small (40pt)")
                            .typography(.bodyMedium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        FloatingActionButton(icon: "plus", size: .small) { tapCount += 1 }
                    }
                    HStack {
                        Text("Regular (56pt)")
                            .typography(.bodyMedium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        FloatingActionButton(icon: "plus", size: .regular) { tapCount += 1 }
                    }
                    HStack {
                        Text("Large (96pt)")
                            .typography(.bodyMedium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        FloatingActionButton(icon: "plus", size: .large) { tapCount += 1 }
                    }
                }
            }

            SectionCard(title: "アイコン") {
                VariantShowcase(title: "SF Symbols", description: "任意のアイコンが使用可能") {
                    HStack(spacing: spacing.lg) {
                        FloatingActionButton(icon: "plus") { tapCount += 1 }
                        FloatingActionButton(icon: "pencil") { tapCount += 1 }
                        FloatingActionButton(icon: "camera") { tapCount += 1 }
                        FloatingActionButton(icon: "trash") { tapCount += 1 }
                    }
                }
            }

            SectionCard(title: "使用例") {
                CodeExample(code: """
                    FloatingActionButton(
                        icon: "plus",
                        size: .regular
                    ) {
                        // アクション
                    }
                    """)
            }

            SectionCard(title: "レイアウト例") {
                VariantShowcase(title: "右下配置", description: "典型的な使用パターン") {
                    ZStack(alignment: .bottomTrailing) {
                        RoundedRectangle(cornerRadius: radius.lg)
                            .fill(colors.surfaceVariant.opacity(0.3))
                            .frame(height: 200)

                        FloatingActionButton(icon: "plus") { tapCount += 1 }
                            .padding(spacing.lg)
>>>>>>> upstream/main
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FloatingActionButtonCatalogView()
            .theme(ThemeProvider())
    }
}
