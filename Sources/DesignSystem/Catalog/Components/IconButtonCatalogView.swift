import SwiftUI

/// IconButton component catalog view
struct IconButtonCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var tapCount = 0

    var body: some View {
        CatalogPageContainer(title: "IconButton") {
            VStack(alignment: .leading, spacing: spacing.sm) {
                CatalogOverview(description: "アイコンのみで構成される、コンパクトなアクションボタン")

                if tapCount > 0 {
                    Text("タップ: \(tapCount)")
