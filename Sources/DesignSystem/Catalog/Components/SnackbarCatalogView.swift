import SwiftUI

/// Snackbar component catalog view
struct SnackbarCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var snackbarState = SnackbarState()

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: spacing.xl) {
                    CatalogOverview(description: "画面下部から表示される一時的な通知UI")

                    SectionCard(title: "基本") {
                        VariantShowcase(title: "シンプル", description: "メッセージのみ") {
                            Button("表示") {
                                snackbarState.show(message: "保存しました", duration: 3.0)
