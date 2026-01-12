import SwiftUI

/// IconPicker (SF Symbols) catalog view
struct IconPickerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var selectedIcon: String?
    @State private var showIconPicker = false

    var body: some View {
        CatalogPageContainer(title: "IconPicker") {
            CatalogOverview(description: "SF Symbolsアイコンを選択")

            SectionCard(title: "デモ") {
                VStack(spacing: spacing.md) {
                    iconPreview

                    Button(selectedIcon == nil ? "アイコンを選択" : "アイコンを変更") {
                        showIconPicker = true
