import SwiftUI

/// Button component catalog view
struct ButtonCatalogView: View {
    @Environment(\.spacingScale) private var spacing
    @State private var isButtonEnabled = true

    var body: some View {
        CatalogPageContainer(title: "Button") {
            CatalogOverview(description: "ボタンのバリエーションとサイズを確認できます")

            Toggle("ボタンを有効化", isOn: $isButtonEnabled)
                .padding(.horizontal, spacing.lg)

            SectionCard(title: "Primary") {
                VariantShowcase(
                    title: "Primary Button",
                    description: "主要なアクションに使用"
                ) {
                    VStack(spacing: spacing.md) {
                        Button("Large") { }
                            .buttonStyle(.primary)
                            .buttonSize(.large)

                        Button("Medium") { }
                            .buttonStyle(.primary)
                            .buttonSize(.medium)

                        Button("Small") { }
                            .buttonStyle(.primary)
                            .buttonSize(.small)
