import SwiftUI

/// EmojiPicker catalog view
struct EmojiPickerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var selectedEmoji: String?
    @State private var showEmojiPicker = false

    var body: some View {
        CatalogPageContainer(title: "EmojiPicker") {
            CatalogOverview(description: "カテゴリ別の絵文字を選択")

            SectionCard(title: "デモ") {
                VStack(spacing: spacing.md) {
                    emojiPreview

                    Button(selectedEmoji == nil ? "絵文字を選択" : "絵文字を変更") {
                        showEmojiPicker = true
