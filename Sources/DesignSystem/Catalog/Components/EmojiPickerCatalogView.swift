import SwiftUI

/// Catalog view for EmojiPicker component
struct EmojiPickerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    @State private var selectedEmoji: String?
    @State private var showEmojiPicker = false

    var body: some View {
        CatalogPageContainer(title: "EmojiPicker") {
            CatalogOverview(description: "Select emoji by category")

            SectionCard(title: "Demo") {
                VStack(spacing: spacing.md) {
                    emojiPreview

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

            SectionCard(title: "Usage Examples") {
                CodeExample(code: """
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
            }
        }
    }

    @ViewBuilder
    private var emojiPreview: some View {
        HStack(spacing: spacing.md) {
            if let emoji = selectedEmoji {
                Text(emoji)
                    .font(.system(size: 48))
                    .frame(width: 60, height: 60)
                    .background(colors.primaryContainer)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Text(emoji)
                    .typography(.headlineMedium)
                    .foregroundStyle(colors.onSurface)
            } else {
                Text("Please select an emoji")
                    .typography(.bodyMedium)
                    .foregroundStyle(colors.onSurfaceVariant)
            }

            Spacer()
        }
        .padding(spacing.md)
        .background(colors.surfaceVariant.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

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
                displayName: "Food & Drinks",
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
