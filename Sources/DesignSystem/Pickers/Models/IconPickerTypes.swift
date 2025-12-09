import Foundation

/// Icon item (for SF Symbols).
///
/// Represents an individual SF Symbols icon shown in the icon picker.
///
/// `systemName` should be an SF Symbols name (e.g. `"star.fill"`, `"heart.circle"`).
///
/// ## Note
/// This picker is for SF Symbols only. For emojis, use `EmojiPicker`.
public struct IconItem: Identifiable, Sendable, Hashable {
    public let id: String
    public let systemName: String
    public let displayName: String?

    public init(id: String, systemName: String, displayName: String? = nil) {
        self.id = id
        self.systemName = systemName
        self.displayName = displayName
    }
}

/// Protocol representing an icon category.
///
/// Used to group icons for the icon picker.
public protocol IconCategoryProtocol: Identifiable, Sendable {
    var id: String { get }
    var displayName: String { get }
    var icons: [IconItem] { get }
}

/// Generic icon category implementation (for SF Symbols).
///
/// ## Example
/// ```swift
/// let generalCategory = IconCategory(
///     id: "general",
///     displayName: "General",
///     icons: [
///         IconItem(id: "book", systemName: "book.fill", displayName: "Book"),
///         IconItem(id: "briefcase", systemName: "briefcase.fill", displayName: "Business"),
///     ]
/// )
///
/// struct MyView: View {
///     @State private var selectedIcon: String?
///     @State private var showIconPicker = false
///     let categories = [generalCategory, /* ... */]
///
///     var body: some View {
///         Button("Select SF Symbol") {
///             showIconPicker = true
///         }
///         .iconPicker(
///             categories: categories,
///             selectedIcon: $selectedIcon,
///             isPresented: $showIconPicker
///         )
///     }
/// }
/// ```
public struct IconCategory: IconCategoryProtocol {
    public let id: String
    public let displayName: String
    public let icons: [IconItem]

    public init(id: String, displayName: String, icons: [IconItem]) {
        self.id = id
        self.displayName = displayName
        self.icons = icons
    }
}
