import SwiftUI

/// Snackbar component catalog view
struct SnackbarCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var snackbarState = SnackbarState()

    var body: some View {
        ZStack {
            ScrollView {
<<<<<<< HEAD
                VStack(alignment: .leading, spacing: 24) {
                    // Overview
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Snackbars are temporary notification UIs that appear from the bottom of the screen.")
                            .typography(.bodyMedium)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        Text("They display feedback for user actions and brief messages.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)
                    }
                    .padding(.horizontal, spacing.lg)
                    .padding(.top, spacing.lg)

                    // Basic usage
                    SectionCard(title: "Basic Usage") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Simple message only")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)

                            Button {
                                snackbarState.show(
                                    message: "保存しました",
                                    duration: 3.0
                                )
                            } label: {
                                Text("Show simple Snackbar")
                                    .typography(.labelLarge)
=======
                VStack(spacing: spacing.xl) {
                    CatalogOverview(description: "画面下部から表示される一時的な通知UI")

                    SectionCard(title: "基本") {
                        VariantShowcase(title: "シンプル", description: "メッセージのみ") {
                            Button("表示") {
                                snackbarState.show(message: "保存しました", duration: 3.0)
>>>>>>> upstream/main
                            }
                            .buttonStyle(.primary)
                        }
                    }

<<<<<<< HEAD
                    // With actions
                    SectionCard(title: "With Action") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("With a primary action")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)

                            Button {
                                snackbarState.show(
                                    message: "削除しました",
                                    primaryAction: SnackbarAction(title: "Undo") {
                                        // Simulate undo action
                                        print("Undo")
                                    },
                                    duration: 5.0
                                )
                            } label: {
                                Text("Snackbar with action")
                                    .typography(.labelLarge)
                            }
                            .buttonStyle(.primary)
                        }
                    }

                    // Multiple actions
                    SectionCard(title: "Multiple Actions") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Primary and secondary actions")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)

                            Button {
                                snackbarState.show(
                                    message: "ファイルを削除しますか？",
                                    primaryAction: SnackbarAction(title: "Delete") {
                                        print("Delete")
                                    },
                                    secondaryAction: SnackbarAction(title: "Cancel") {
                                        print("Cancel")
                                    },
                                    duration: 7.0
                                )
                            } label: {
                                Text("Snackbar with multiple actions")
                                    .typography(.labelLarge)
                            }
                            .buttonStyle(.primary)
                        }
                    }

                    // Long message
                    SectionCard(title: "Long Messages") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Multi-line messages (up to two lines).")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)

                            Button {
                                snackbarState.show(
                                    message: "A network error occurred. Check your connection and try again.",
                                    primaryAction: SnackbarAction(title: "Retry") {
                                        print("Retry")
                                    },
                                    duration: 5.0
                                )
                            } label: {
                                Text("Snackbar with long message")
                                    .typography(.labelLarge)
                            }
                            .buttonStyle(.primary)
                        }
                    }

                    // Custom display duration
                    SectionCard(title: "Custom Duration") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Customize how long the Snackbar is shown.")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)

                            HStack(spacing: spacing.md) {
                                Button {
                                    snackbarState.show(
                                        message: "Hides after 3 seconds.",
                                        duration: 3.0
                                    )
                                } label: {
                                    Text("3 seconds")
                                        .typography(.labelMedium)
                                }
                                .buttonStyle(.secondary)

                                Button {
                                    snackbarState.show(
                                        message: "Hides after 5 seconds.",
                                        duration: 5.0
                                    )
                                } label: {
                                    Text("5 seconds")
                                        .typography(.labelMedium)
=======
                    SectionCard(title: "アクション付き") {
                        VStack(alignment: .leading, spacing: spacing.md) {
                            VariantShowcase(title: "単一アクション") {
                                Button("表示") {
                                    snackbarState.show(
                                        message: "削除しました",
                                        primaryAction: SnackbarAction(title: "元に戻す") {},
                                        duration: 5.0
                                    )
>>>>>>> upstream/main
                                }
                                .buttonStyle(.primary)
                            }

                            Divider()

                            VariantShowcase(title: "複数アクション") {
                                Button("表示") {
                                    snackbarState.show(
<<<<<<< HEAD
                                        message: "Hides after 10 seconds.",
                                        duration: 10.0
                                    )
                                } label: {
                                    Text("10 seconds")
                                        .typography(.labelMedium)
=======
                                        message: "ファイルを削除しますか？",
                                        primaryAction: SnackbarAction(title: "削除") {},
                                        secondaryAction: SnackbarAction(title: "キャンセル") {},
                                        duration: 7.0
                                    )
>>>>>>> upstream/main
                                }
                                .buttonStyle(.primary)
                            }
                        }
                    }

<<<<<<< HEAD
                    // Usage notes
                    SectionCard(title: "Usage Notes") {
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Keep messages concise (1–2 lines).", systemImage: "checkmark.circle.fill")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.success)

                            Label("Limit to at most two actions.", systemImage: "checkmark.circle.fill")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.success)

                            Label("Recommended auto-dismiss duration is 3–7 seconds.", systemImage: "checkmark.circle.fill")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.success)

                            Label("Ensure enough time for important actions.", systemImage: "checkmark.circle.fill")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.success)
=======
                    SectionCard(title: "表示時間") {
                        HStack(spacing: spacing.md) {
                            Button("3秒") {
                                snackbarState.show(message: "3秒で消えます", duration: 3.0)
                            }
                            .buttonStyle(.secondary)

                            Button("5秒") {
                                snackbarState.show(message: "5秒で消えます", duration: 5.0)
                            }
                            .buttonStyle(.secondary)

                            Button("10秒") {
                                snackbarState.show(message: "10秒で消えます", duration: 10.0)
                            }
                            .buttonStyle(.secondary)
                        }
                    }

                    SectionCard(title: "ベストプラクティス") {
                        VStack(alignment: .leading, spacing: spacing.md) {
                            BestPracticeItem(icon: "checkmark.circle.fill", title: "簡潔なメッセージ", description: "1-2行で収まるように", isGood: true)
                            BestPracticeItem(icon: "checkmark.circle.fill", title: "アクションは最大2つ", description: "多すぎると判断が難しくなる", isGood: true)
                            BestPracticeItem(icon: "checkmark.circle.fill", title: "表示時間3-7秒", description: "重要な操作には十分な時間を確保", isGood: true)
>>>>>>> upstream/main
                        }
                    }
                }
                .padding(.bottom, 100)
            }
            .background(colors.background)

            Snackbar(state: snackbarState)
        }
        .navigationTitle("Snackbar")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        SnackbarCatalogView()
            .theme(ThemeProvider())
    }
}
