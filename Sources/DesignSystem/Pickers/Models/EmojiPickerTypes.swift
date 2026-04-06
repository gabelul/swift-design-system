import Foundation

/// Emoji item
///
/// Represents an individual emoji displayed in the emoji picker.
public struct EmojiItem: Identifiable, Sendable, Hashable {
    public let id: String
    public let emoji: String
    public let displayName: String?

    public init(id: String, emoji: String, displayName: String? = nil) {
        self.id = id
        self.emoji = emoji
        self.displayName = displayName
    }
}

/// Protocol representing an emoji category
///
/// Used to group emojis into categories.
public protocol EmojiCategoryProtocol: Identifiable, Sendable {
    var id: String { get }
    var displayName: String { get }
    var emojis: [EmojiItem] { get }
}

/// General-purpose emoji category implementation
///
/// ## Usage
/// ```swift
/// let smileyCategory = EmojiCategory(
///     id: "smileys",
///     displayName: "Faces & Emotions",
///     emojis: [
///         EmojiItem(id: "smile", emoji: "😊", displayName: "Smile"),
///         EmojiItem(id: "laugh", emoji: "😂", displayName: "Laugh"),
///     ]
/// )
///
/// struct MyView: View {
///     @State private var selectedEmoji: String?
///     @State private var showEmojiPicker = false
///     let categories = [smileyCategory, /* ... */]
///
///     var body: some View {
///         Button("Choose Emoji") {
///             showEmojiPicker = true
///         }
///         .emojiPicker(
///             categories: categories,
///             selectedEmoji: $selectedEmoji,
///             isPresented: $showEmojiPicker
///         )
///     }
/// }
/// ```
public struct EmojiCategory: EmojiCategoryProtocol {
    public let id: String
    public let displayName: String
    public let emojis: [EmojiItem]

    public init(id: String, displayName: String, emojis: [EmojiItem]) {
        self.id = id
        self.displayName = displayName
        self.emojis = emojis
    }
}
