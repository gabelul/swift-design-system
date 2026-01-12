import SwiftUI

/// ViewModifier for displaying emoji picker
///
/// ## Usage Examples
/// ```swift
/// struct MyView: View {
///     @State private var selectedEmoji: String?
///     @State private var showEmojiPicker = false
///
///     let categories = [
///         EmojiCategory(
///             id: "smileys",
///             displayName: "Faces & Emotions",
///             emojis: [
///                 EmojiItem(id: "smile", emoji: "😊", displayName: "Smile"),
///                 EmojiItem(id: "laugh", emoji: "😂", displayName: "Laugh"),
///             ]
///         )
///     ]
///
///     var body: some View {
///         Button("Select Emoji") {
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
///
/// ## Note
/// This picker is for emojis only. Use `.iconPicker()` for SF Symbols.
public struct EmojiPickerModifier: ViewModifier {
    let categories: [any EmojiCategoryProtocol]
    @Binding var selectedEmoji: String?
    @Binding var isPresented: Bool

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                DSEmojiPickerView(
                    categories: categories,
                    selectedEmoji: $selectedEmoji,
                    isPresented: $isPresented
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
    }
}

// MARK: - View Extension

public extension View {
    /// Displays emoji picker
    ///
    /// - Parameters:
    ///   - categories: List of emoji categories to display
    ///   - selectedEmoji: Value of selected emoji
    ///   - isPresented: Picker display state
    /// - Returns: View with emoji picker added
    func emojiPicker(
        categories: [any EmojiCategoryProtocol],
        selectedEmoji: Binding<String?>,
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(EmojiPickerModifier(
            categories: categories,
            selectedEmoji: selectedEmoji,
            isPresented: isPresented
        ))
    }
}

// MARK: - Internal View

/// Internal implementation view of emoji picker (private)
struct DSEmojiPickerView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius
    @Environment(\.dismiss) private var dismiss

    let categories: [any EmojiCategoryProtocol]
    @Binding var selectedEmoji: String?
    @Binding var isPresented: Bool

    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                searchBar
                    .padding(.horizontal, spacing.md)
                    .padding(.vertical, spacing.sm)

                // Emoji display by category
                ScrollView {
                    VStack(alignment: .leading, spacing: spacing.lg) {
                        ForEach(Array(filteredCategories.enumerated()), id: \.offset) { index, category in
                            categorySection(category)

                            if index < filteredCategories.count - 1 {
                                Divider()
                                    .padding(.vertical, spacing.sm)
                            }
                        }
                    }
                    .padding(spacing.md)
                }
            }
            .background(colors.background)
            .navigationTitle("Select Emoji")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(colors.onSurfaceVariant)
                }

                ToolbarItem(placement: .confirmationAction) {
                    if selectedEmoji != nil {
                        Button("Clear") {
                            selectedEmoji = nil
                            dismiss()
                        }
                        .foregroundColor(colors.primary)
                    }
                }
            }
        }
    }

    private var searchBar: some View {
        HStack(spacing: spacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundColor(colors.onSurfaceVariant)

            TextField("Search emojis...", text: $searchText)
                .autocorrectionDisabled()

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(colors.onSurfaceVariant)
                }
            }
        }
        .padding(spacing.sm)
        .background(colors.surfaceVariant.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: radius.sm))
    }

    private func categorySection(_ category: any EmojiCategoryProtocol) -> some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            Text(category.displayName)
                .font(.headline)
                .foregroundColor(colors.onSurface)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: spacing.sm), count: 6),
                spacing: spacing.sm
            ) {
                ForEach(category.emojis) { emoji in
                    EmojiPickerButton(
                        emoji: emoji,
                        isSelected: selectedEmoji == emoji.emoji,
                        onTap: {
                            selectedEmoji = emoji.emoji
                            dismiss()
                        }
                    )
                }
            }
        }
    }

    private var filteredCategories: [any EmojiCategoryProtocol] {
        if searchText.isEmpty {
            return categories
        }

        return categories.compactMap { category -> (any EmojiCategoryProtocol)? in
            let filteredEmojis = category.emojis.filter { emoji in
                emoji.emoji.localizedCaseInsensitiveContains(searchText) ||
                (emoji.displayName?.localizedCaseInsensitiveContains(searchText) ?? false)
            }

            if filteredEmojis.isEmpty {
                return nil
            }

            return EmojiCategory(
                id: category.id,
                displayName: category.displayName,
                emojis: filteredEmojis
            )
        }
    }
}

// MARK: - Emoji Picker Button

private struct EmojiPickerButton: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.radiusScale) private var radius

    let emoji: EmojiItem
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            Text(emoji.emoji)
                .font(.system(size: 32))
                .frame(width: 50, height: 50)
                .background(
                    isSelected
                        ? colors.primaryContainer
                        : colors.surfaceVariant.opacity(0.5)
                )
                .clipShape(RoundedRectangle(cornerRadius: radius.sm))
                .overlay(
                    RoundedRectangle(cornerRadius: radius.sm)
                        .stroke(
                            isSelected ? colors.primary : Color.clear,
                            lineWidth: 2
                        )
                )
        }
    }
}
