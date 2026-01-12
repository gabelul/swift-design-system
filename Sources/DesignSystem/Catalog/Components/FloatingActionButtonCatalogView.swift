import SwiftUI

/// FAB component catalog view
struct FloatingActionButtonCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius
    @State private var tapCount = 0

    var body: some View {
        CatalogPageContainer(title: "FAB") {
            VStack(alignment: .leading, spacing: spacing.sm) {
                CatalogOverview(description: "画面上で最も重要なアクションを表すボタン")

                if tapCount > 0 {
                    Text("タップ回数: \(tapCount)")
