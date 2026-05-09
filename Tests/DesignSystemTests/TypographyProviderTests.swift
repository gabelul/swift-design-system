import XCTest
@testable import DesignSystem

final class TypographyProviderTests: XCTestCase {
    func testFontNameFallsBackToSansForSerifAndMonoWhenNeeded() {
        let provider = TypographyProvider(sansFontName: "Inter")

        XCTAssertEqual(provider.fontName(for: .default), "Inter")
        XCTAssertEqual(provider.fontName(for: .serif), "Inter")
        XCTAssertEqual(provider.fontName(for: .monospaced), "Inter")
    }

    func testExplicitFontNamesOverrideFallbacks() {
        let provider = TypographyProvider(
            sansFontName: "Inter",
            serifFontName: "SourceSerif4",
            monoFontName: "JetBrainsMono"
        )

        XCTAssertEqual(provider.fontName(for: .default), "Inter")
        XCTAssertEqual(provider.fontName(for: .serif), "SourceSerif4")
        XCTAssertEqual(provider.fontName(for: .monospaced), "JetBrainsMono")
    }

    func testPointSizeAndLineSpacingScaleWithProvider() {
        let provider = TypographyProvider(scale: 1.25)

        XCTAssertEqual(provider.pointSize(for: .headlineMedium), 35, accuracy: 0.001)
        XCTAssertEqual(provider.lineSpacing(for: .headlineMedium), 10, accuracy: 0.001)
        XCTAssertEqual(provider.pointSize(for: .labelSmall), 13.75, accuracy: 0.001)
        XCTAssertEqual(provider.lineSpacing(for: .labelSmall), 6.25, accuracy: 0.001)
    }
}
