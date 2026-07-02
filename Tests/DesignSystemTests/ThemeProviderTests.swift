import XCTest
@testable import DesignSystem

@MainActor
final class ThemeProviderTests: XCTestCase {
    func testInitializationUsesDefaultThemeAndSystemMode() {
        let provider = ThemeProvider()

        XCTAssertEqual(provider.currentTheme.id, "default")
        XCTAssertEqual(provider.themeMode, .system)
        XCTAssertFalse(provider.availableThemes.isEmpty)
    }

    func testInitializationWithCustomMode() {
        let provider = ThemeProvider(initialMode: .dark)

        XCTAssertEqual(provider.themeMode, .dark)
    }

    func testSwitchToThemeByIdentifier() {
        let provider = ThemeProvider()

        provider.switchToTheme(id: "ocean")

        XCTAssertEqual(provider.currentTheme.id, "ocean")
    }

    func testSwitchToUnknownThemeIsNoOp() {
        let provider = ThemeProvider()
        let before = provider.currentTheme.id

        provider.switchToTheme(id: "nonexistent-theme")
        XCTAssertEqual(provider.currentTheme.id, before)
    }

    func testApplyThemeReplacesCurrentTheme() {
        let provider = ThemeProvider()
        let theme = ForestTheme()

        provider.applyTheme(theme)

        XCTAssertEqual(provider.currentTheme.id, theme.id)
    }

    func testToggleModeCyclesThroughAllModes() {
        let provider = ThemeProvider(initialMode: .system)

        provider.toggleMode()
        XCTAssertEqual(provider.themeMode, .light)

        provider.toggleMode()
        XCTAssertEqual(provider.themeMode, .dark)

        provider.toggleMode()
        XCTAssertEqual(provider.themeMode, .system)
    }

    func testRegisterThemeAppendsMissingTheme() {
        let provider = ThemeProvider()
        let initialCount = provider.availableThemes.count
        let customTheme = DynamicTheme(brandColor: .indigo)

        provider.registerTheme(customTheme)

        XCTAssertEqual(provider.availableThemes.count, initialCount + 1)
        XCTAssertTrue(provider.availableThemes.contains(where: { $0.id == customTheme.id }))
    }

    func testRegisterThemeReplacesExistingThemeWithSameIdentifier() {
        let provider = ThemeProvider(initialTheme: DynamicTheme(brandColor: .indigo))
        let replacement = DynamicTheme(brandColor: .mint)

        provider.registerTheme(replacement)

        let matches = provider.availableThemes.filter { $0.id == replacement.id }
        XCTAssertEqual(matches.count, 1)
    }

    func testColorPaletteIsAccessible() {
        let provider = ThemeProvider(initialMode: .light)
        // Just confirm the mode-resolved palette is reachable without crashing.
        _ = provider.colorPalette
        XCTAssertEqual(provider.themeMode, .light)
    }
}
