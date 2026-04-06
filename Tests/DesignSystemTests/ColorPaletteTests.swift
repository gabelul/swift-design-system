import XCTest
@testable import DesignSystem

final class ColorPaletteTests: XCTestCase {
    func testLightColorPalette() {
        let palette = LightColorPalette()

        // Primary colors
        XCTAssertNotNil(palette.primary)
        XCTAssertNotNil(palette.onPrimary)
        XCTAssertNotNil(palette.primaryContainer)
        XCTAssertNotNil(palette.onPrimaryContainer)

        // Background & Surface
        XCTAssertNotNil(palette.background)
        XCTAssertNotNil(palette.onBackground)
        XCTAssertNotNil(palette.surface)
        XCTAssertNotNil(palette.onSurface)

        // Semantic state colors
        XCTAssertNotNil(palette.error)
        XCTAssertNotNil(palette.warning)
        XCTAssertNotNil(palette.success)
        XCTAssertNotNil(palette.info)
    }

    func testDarkColorPalette() {
        let palette = DarkColorPalette()

        // Primary colors
        XCTAssertNotNil(palette.primary)
        XCTAssertNotNil(palette.onPrimary)

        // Background & Surface
        XCTAssertNotNil(palette.background)
        XCTAssertNotNil(palette.onBackground)
        XCTAssertNotNil(palette.surface)
        XCTAssertNotNil(palette.onSurface)
    }

    func testDefaultImplementations() {
        let palette = LightColorPalette()

        // Protocol extensionのデフォルト実装が機能することを確認
        XCTAssertNotNil(palette.primaryContainer)
        XCTAssertNotNil(palette.secondaryContainer)
        XCTAssertNotNil(palette.errorContainer)
        XCTAssertNotNil(palette.outlineVariant)
    }
}
