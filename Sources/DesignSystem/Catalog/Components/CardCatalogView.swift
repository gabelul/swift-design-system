import SwiftUI

/// Card component catalog view
struct CardCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "Card") {
            CatalogOverview(description: "関連情報をグループ化する汎用コンテナ")

            SectionCard(title: "基本") {
                VariantShowcase(
                    title: "デフォルト設定",
                    description: "Elevation Level 1、パディング 16pt"
                ) {
                    Card {
                        VStack(alignment: .leading, spacing: spacing.sm) {
                            Text("カードタイトル")
                                .typography(.titleMedium)
                            Text("カードの本文テキスト")
                                .typography(.bodyMedium)
