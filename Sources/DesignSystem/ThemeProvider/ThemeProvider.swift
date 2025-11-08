import SwiftUI

/// テーマプロバイダー
///
/// アプリ全体のテーマ（Light/Dark/カスタム）を管理し、デザイントークンをEnvironmentに提供します。
/// `@Observable`により、テーマ変更時にUIが自動的に更新されます。
///
/// ## 基本的な使い方
/// ```swift
/// @main
/// struct MyApp: App {
///     @State private var themeProvider = ThemeProvider()
///
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///                 .theme(themeProvider)
///         }
///     }
/// }
/// ```
///
/// ## テーマの切り替え
/// ```swift
/// @Environment(\.themeProvider) var themeProvider
///
/// // ダークモードに切り替え
/// Button("ダークモード") {
///     themeProvider?.switchToDark()
/// }
///
/// // ライトモードに切り替え
/// Button("ライトモード") {
///     themeProvider?.switchToLight()
/// }
/// ```
///
/// ## カスタムテーマの適用
/// ```swift
/// struct MyBrandPalette: ColorPalette {
///     var primary: Color { Color(hex: "#FF6B35") }
///     // ... その他の色を定義
/// }
///
/// // カスタムテーマを適用
/// themeProvider?.applyCustomTheme(colorPalette: MyBrandPalette())
/// ```
@Observable
@MainActor
public final class ThemeProvider {
    /// 現在のカラースキーム
    public var colorScheme: ThemeColorScheme

    /// カスタムカラーパレット（nilの場合は標準テーマを使用）
    public var customColorPalette: (any ColorPalette)?

    /// Light用カラーパレット（初期化時に指定可能）
    private let lightPalette: any ColorPalette

    /// Dark用カラーパレット（初期化時に指定可能）
    private let darkPalette: any ColorPalette

    /// 現在のカラーパレット
    public var colorPalette: any ColorPalette {
        if let custom = customColorPalette {
            return custom
        }

        switch colorScheme {
        case .light:
            return lightPalette
        case .dark:
            return darkPalette
        }
    }

    /// ThemeProviderを初期化
    ///
    /// - Parameters:
    ///   - colorScheme: 初期カラースキーム（デフォルト: `.light`）
    ///   - lightPalette: Lightモード用カラーパレット（デフォルト: `LightColorPalette()`）
    ///   - darkPalette: Darkモード用カラーパレット（デフォルト: `DarkColorPalette()`）
    ///
    /// ## カスタムパレットでの初期化
    /// ```swift
    /// let themeProvider = ThemeProvider(
    ///     lightPalette: MyBrandLightPalette(),
    ///     darkPalette: MyBrandDarkPalette()
    /// )
    /// ```
    public init(
        colorScheme: ThemeColorScheme = .light,
        lightPalette: any ColorPalette = LightColorPalette(),
        darkPalette: any ColorPalette = DarkColorPalette()
    ) {
        self.colorScheme = colorScheme
        self.lightPalette = lightPalette
        self.darkPalette = darkPalette
    }

    /// ライトテーマに切り替え
    ///
    /// カスタムテーマが設定されている場合は解除され、標準のLightテーマが適用されます。
    public func switchToLight() {
        colorScheme = .light
        customColorPalette = nil
    }

    /// ダークテーマに切り替え
    ///
    /// カスタムテーマが設定されている場合は解除され、標準のDarkテーマが適用されます。
    public func switchToDark() {
        colorScheme = .dark
        customColorPalette = nil
    }

    /// カスタムテーマを適用
    ///
    /// - Parameter colorPalette: 適用するカスタムカラーパレット
    ///
    /// ## 使用例
    /// ```swift
    /// struct MyBrandPalette: ColorPalette {
    ///     var primary: Color { Color(hex: "#FF6B35") }
    ///     // ... その他の色
    /// }
    ///
    /// themeProvider.applyCustomTheme(colorPalette: MyBrandPalette())
    /// ```
    public func applyCustomTheme(colorPalette: any ColorPalette) {
        self.customColorPalette = colorPalette
    }

    /// システムのカラースキームに追従
    ///
    /// SwiftUIの`ColorScheme`を受け取り、Light/Darkテーマを自動切り替えします。
    /// カスタムテーマが設定されている場合は解除されます。
    ///
    /// - Parameter systemColorScheme: SwiftUIの`ColorScheme`
    ///
    /// ## 使用例
    /// ```swift
    /// @Environment(\.colorScheme) var systemColorScheme
    /// @Environment(\.themeProvider) var themeProvider
    ///
    /// .onAppear {
    ///     themeProvider?.followSystem(systemColorScheme)
    /// }
    /// ```
    public func followSystem(_ systemColorScheme: ColorScheme) {
        colorScheme = systemColorScheme == .dark ? .dark : .light
        customColorPalette = nil
    }
}
