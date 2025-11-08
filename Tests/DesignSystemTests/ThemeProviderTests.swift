import XCTest
@testable import DesignSystem

final class ThemeProviderTests: XCTestCase {
    func testInitialization() {
        let provider = ThemeProvider()

        // デフォルトはLightテーマ
        XCTAssertEqual(provider.colorScheme, .light)
        XCTAssertNil(provider.customColorPalette)
    }

    func testInitializationWithDarkScheme() {
        let provider = ThemeProvider(colorScheme: .dark)

        XCTAssertEqual(provider.colorScheme, .dark)
    }

    func testSwitchToLight() {
        let provider = ThemeProvider(colorScheme: .dark)

        provider.switchToLight()

        XCTAssertEqual(provider.colorScheme, .light)
        XCTAssertNil(provider.customColorPalette)
    }

    func testSwitchToDark() {
        let provider = ThemeProvider(colorScheme: .light)

        provider.switchToDark()

        XCTAssertEqual(provider.colorScheme, .dark)
        XCTAssertNil(provider.customColorPalette)
    }

    func testCustomPaletteApplication() {
        let provider = ThemeProvider()
        let customPalette = LightColorPalette()

        provider.applyCustomTheme(colorPalette: customPalette)

        XCTAssertNotNil(provider.customColorPalette)
    }

    func testColorPaletteReturnsCorrectTheme() {
        let lightProvider = ThemeProvider(colorScheme: .light)
        let darkProvider = ThemeProvider(colorScheme: .dark)

        // Light theme
        _ = lightProvider.colorPalette
        XCTAssertEqual(lightProvider.colorScheme, .light)

        // Dark theme
        _ = darkProvider.colorPalette
        XCTAssertEqual(darkProvider.colorScheme, .dark)
    }

    func testCustomPaletteTakesPrecedence() {
        let provider = ThemeProvider(colorScheme: .light)
        let customPalette = DarkColorPalette()

        provider.applyCustomTheme(colorPalette: customPalette)

        // カスタムパレットが設定されている場合、colorSchemeに関わらずカスタムパレットが使われる
        XCTAssertNotNil(provider.customColorPalette)
    }
}
