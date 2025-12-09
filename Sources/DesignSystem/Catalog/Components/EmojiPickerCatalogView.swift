import SwiftUI

/// EmojiPicker catalog view
struct EmojiPickerCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    @State private var selectedEmoji: String?
    @State private var showEmojiPicker = false

    var body: some View {
        ScrollView {
            VStack(spacing: spacing.xl) {
                // Header
                headerSection

                // Basic usage
                basicUsageSection

                // Code example
                codeExampleSection
            }
            .padding(spacing.lg)
        }
        .background(colorPalette.background)
        .navigationTitle("EmojiPicker")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private var headerSection: some View {
        VStack(spacing: spacing.md) {
            Image(systemName: "face.smiling")
                .font(.system(size: 48))
                .foregroundStyle(colorPalette.primary)

            Text("EmojiPicker")
                .typography(.headlineLarge)
                .foregroundStyle(colorPalette.onBackground)

            Text("Select emojis by category.")
                .typography(.bodyMedium)
                .foregroundStyle(colorPalette.onSurfaceVariant)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private var basicUsageSection: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("Basic usage")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)

            Text("Emoji picker organized by category.")
                .typography(.bodySmall)
                .foregroundStyle(colorPalette.onSurfaceVariant)

            VStack(spacing: spacing.md) {
                // 選択された絵文字のプレビュー
                HStack(spacing: spacing.md) {
                    if let emoji = selectedEmoji {
                        Text(emoji)
                            .font(.system(size: 48))
                            .frame(width: 60, height: 60)
                            .background(colorPalette.primaryContainer)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Selected emoji")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)
                            Text(emoji)
                                .typography(.headlineMedium)
                                .foregroundStyle(colorPalette.onSurface)
                        }
                    } else {
                        Text("Select an emoji.")
                            .typography(.bodyMedium)
                            .foregroundStyle(colorPalette.onSurfaceVariant)
                    }

                    Spacer()
                }
                .padding(spacing.md)
                .background(colorPalette.surfaceVariant.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // Select button
                Button(selectedEmoji == nil ? "Select Emoji" : "Change Emoji") {
                    showEmojiPicker = true
                }
                .buttonStyle(.primary)
                .buttonSize(.medium)
                .emojiPicker(
                    categories: sampleEmojiCategories,
                    selectedEmoji: $selectedEmoji,
                    isPresented: $showEmojiPicker
                )
            }
        }
    }

    private var codeExampleSection: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("Code example")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)

            VStack(alignment: .leading, spacing: spacing.sm) {
                codeBlock("""
                    @State private var selectedEmoji: String?
                    @State private var showEmojiPicker = false

                    let categories = [
                        EmojiCategory(
                            id: "smileys",
                            displayName: "Faces & Emotions",
                            emojis: [
                                EmojiItem(id: "smile", emoji: "😊"),
                                EmojiItem(id: "laugh", emoji: "😂")
                            ]
                        )
                    ]

                    Button("Select Emoji") {
                        showEmojiPicker = true
                    }
                    .emojiPicker(
                        categories: categories,
                        selectedEmoji: $selectedEmoji,
                        isPresented: $showEmojiPicker
                    )
                    """)

                Text("Categories and emojis:")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(.top, spacing.sm)

                Text("• EmojiCategory – defines a category.")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                Text("• EmojiItem – defines an individual emoji.")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                Text("• emoji – emoji string (e.g. \"😊\").")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
            }
        }
    }

    private func codeBlock(_ code: String) -> some View {
        Text(code)
            .typography(.bodySmall)
            .fontDesign(.monospaced)
            .foregroundStyle(colorPalette.onSurface)
            .padding(spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colorPalette.surfaceVariant.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    // Sample emoji categories
    private var sampleEmojiCategories: [EmojiCategory] {
        [
            EmojiCategory(
                id: "smileys",
                displayName: "Faces & Emotions",
                emojis: [
                    EmojiItem(id: "smile", emoji: "😊", displayName: "Smile"),
                    EmojiItem(id: "laugh", emoji: "😂", displayName: "Laugh"),
                    EmojiItem(id: "love", emoji: "😍", displayName: "Love"),
                    EmojiItem(id: "cool", emoji: "😎", displayName: "Cool"),
                    EmojiItem(id: "thinking", emoji: "🤔", displayName: "Thinking"),
                    EmojiItem(id: "party", emoji: "🥳", displayName: "Party")
                ]
            ),
            EmojiCategory(
                id: "animals",
                displayName: "Animals & Nature",
                emojis: [
                    EmojiItem(id: "dog", emoji: "🐕", displayName: "Dog"),
                    EmojiItem(id: "cat", emoji: "🐈", displayName: "Cat"),
                    EmojiItem(id: "bird", emoji: "🐦", displayName: "Bird"),
                    EmojiItem(id: "tree", emoji: "🌳", displayName: "Tree"),
                    EmojiItem(id: "flower", emoji: "🌸", displayName: "Flower"),
                    EmojiItem(id: "sun", emoji: "☀️", displayName: "Sun")
                ]
            ),
            EmojiCategory(
                id: "food",
                displayName: "Food & Drink",
                emojis: [
                    EmojiItem(id: "apple", emoji: "🍎", displayName: "Apple"),
                    EmojiItem(id: "pizza", emoji: "🍕", displayName: "Pizza"),
                    EmojiItem(id: "sushi", emoji: "🍣", displayName: "Sushi"),
                    EmojiItem(id: "coffee", emoji: "☕", displayName: "Coffee"),
                    EmojiItem(id: "cake", emoji: "🍰", displayName: "Cake"),
                    EmojiItem(id: "burger", emoji: "🍔", displayName: "Burger")
                ]
            ),
            EmojiCategory(
                id: "activities",
                displayName: "Activities & Sports",
                emojis: [
                    EmojiItem(id: "soccer", emoji: "⚽", displayName: "Soccer"),
                    EmojiItem(id: "basketball", emoji: "🏀", displayName: "Basketball"),
                    EmojiItem(id: "tennis", emoji: "🎾", displayName: "Tennis"),
                    EmojiItem(id: "running", emoji: "🏃", displayName: "Running"),
                    EmojiItem(id: "music", emoji: "🎵", displayName: "Music"),
                    EmojiItem(id: "art", emoji: "🎨", displayName: "Art")
                ]
            )
        ]
    }
}

#Preview {
    NavigationStack {
        EmojiPickerCatalogView()
            .theme(ThemeProvider())
    }
}
