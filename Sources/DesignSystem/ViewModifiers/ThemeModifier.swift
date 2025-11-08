import SwiftUI

/// テーマを適用するView Modifier
public struct ThemeModifier: ViewModifier {
    @Bindable var provider: ThemeProvider

    public init(provider: ThemeProvider) {
        self.provider = provider
    }

    public func body(content: Content) -> some View {
        ThemeEnvironmentView(provider: provider, content: content)
    }
}

/// テーマ環境値を提供する内部ビュー
/// @Bindableによる変更追跡を確実に行うための専用ビュー
private struct ThemeEnvironmentView<Content: View>: View {
    @Bindable var provider: ThemeProvider
    let content: Content

    var body: some View {
        content
            .environment(\.themeProvider, provider)
            .environment(\.colorPalette, provider.colorPalette)
            .environment(\.spacingScale, DefaultSpacingScale())
            .environment(\.radiusScale, DefaultRadiusScale())
    }
}
