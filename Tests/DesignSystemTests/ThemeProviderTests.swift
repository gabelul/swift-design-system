import XCTest
@testable import DesignSystem

@MainActor
final class ThemeProviderTests: XCTestCase {
    func testDefaultInitialization() {
        let provider = ThemeProvider()

        // デフォルトモードは .system、ビルトインテーマが利用可能
        XCTAssertEqual(provider.themeMode, .system)
        XCTAssertFalse(provider.availableThemes.isEmpty)
        XCTAssertEqual(provider.currentTheme.id, "default")
    }

    func testInitializationWithMode() {
        let provider = ThemeProvider(initialMode: .dark)
        XCTAssertEqual(provider.themeMode, .dark)
    }

    func testToggleModeCyclesSystemLightDark() {
        let provider = ThemeProvider(initialMode: .system)

        provider.toggleMode()
        XCTAssertEqual(provider.themeMode, .light)

        provider.toggleMode()
        XCTAssertEqual(provider.themeMode, .dark)

        provider.toggleMode()
        XCTAssertEqual(provider.themeMode, .system)
    }

    func testSwitchToThemeByID() {
        let provider = ThemeProvider()
        guard let target = provider.availableThemes.last else {
            return XCTFail("No bundled themes available")
        }

        provider.switchToTheme(id: target.id)
        XCTAssertEqual(provider.currentTheme.id, target.id)
    }

    func testSwitchToUnknownThemeIsNoOp() {
        let provider = ThemeProvider()
        let before = provider.currentTheme.id

        provider.switchToTheme(id: "nonexistent-theme")
        XCTAssertEqual(provider.currentTheme.id, before)
    }

    func testApplyThemeSetsCurrentTheme() {
        let provider = ThemeProvider()
        guard let target = provider.availableThemes.last else {
            return XCTFail("No bundled themes available")
        }

        provider.applyTheme(target)
        XCTAssertEqual(provider.currentTheme.id, target.id)
    }

    func testRegisterExistingThemeKeepsCountStable() {
        let provider = ThemeProvider()
        let countBefore = provider.availableThemes.count

        // 既存テーマの再登録は in-place 更新（重複追加しない）
        if let existing = provider.availableThemes.first {
            provider.registerTheme(existing)
        }
        XCTAssertEqual(provider.availableThemes.count, countBefore)
    }

    func testColorPaletteIsAccessible() {
        let provider = ThemeProvider(initialMode: .light)
        // モードに応じたパレットが解決できることのみ確認（クラッシュしない）
        _ = provider.colorPalette
        XCTAssertEqual(provider.themeMode, .light)
    }
}
