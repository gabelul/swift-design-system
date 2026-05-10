import SwiftUI
import XCTest
@testable import DesignSystem

@MainActor
final class BrandRecipeTests: XCTestCase {
    func testDynamicRecipeBuildsThemeProviderAndTypography() {
        let recipe = BrandRecipe.dynamic(
            brandColor: .indigo,
            sansFontName: "Inter",
            serifFontName: "SourceSerif4",
            monoFontName: "JetBrainsMono",
            typographyScale: 1.1,
            screenDensity: .spacious,
            themeName: "My Brand",
            themeID: "my-brand"
        )

        XCTAssertEqual(recipe.screenDensity, .spacious)
        XCTAssertEqual(recipe.typographyProvider.fontName(for: .default), "Inter")
        XCTAssertEqual(recipe.typographyProvider.fontName(for: .serif), "SourceSerif4")
        XCTAssertEqual(recipe.typographyProvider.fontName(for: .monospaced), "JetBrainsMono")
        XCTAssertEqual(recipe.typographyProvider.scale, 1.1, accuracy: 0.001)

        let themeProvider = recipe.makeThemeProvider()
        XCTAssertEqual(themeProvider.currentTheme.id, "my-brand")
        XCTAssertEqual(themeProvider.currentTheme.name, "My Brand")
    }

    func testCustomRecipePreservesExplicitThemeAndMode() {
        let recipe = BrandRecipe(
            initialTheme: ForestTheme(),
            initialMode: .dark,
            typographyProvider: TypographyProvider(sansFontName: "Inter"),
            screenDensity: .compact
        )

        let provider = recipe.makeThemeProvider()

        XCTAssertEqual(provider.currentTheme.id, ForestTheme().id)
        XCTAssertEqual(provider.themeMode, .dark)
        XCTAssertEqual(recipe.screenDensity, .compact)
    }
}
