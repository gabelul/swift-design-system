import SwiftUI

/// ColorPicker catalog view
struct ColorPickerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var selectedColor1: String?
    @State private var selectedColor2: String?
    @State private var showColorPicker1 = false
    @State private var showColorPicker2 = false

    var body: some View {
        CatalogPageContainer(title: "ColorPicker") {
            CatalogOverview(description: "プリセットカラーから色を選択")

            SectionCard(title: "tagFriendly") {
                VStack(spacing: spacing.md) {
                    colorPreview(selectedColor: selectedColor1)

                    Button(selectedColor1 == nil ? "色を選択" : "色を変更") {
                        showColorPicker1 = true
