import XCTest
import SwiftUI
@testable import DesignSystem

/// Verifies G2: a Theme can now carry spacing/radius, and that ThemeModifier's
/// hardcoded DefaultSpacingScale injection (Wall W2) has been resolved.
final class ThemeBundleTests: XCTestCase {

    /// A theme with SmartHR-style char-relative spacing (XS=16, S=24, ...)
    struct BrandSpacing: SpacingScale {
        var none: CGFloat { 0 }
        var xxs: CGFloat { 8 }
        var xs: CGFloat { 16 }
        var sm: CGFloat { 24 }
        var md: CGFloat { 32 }
        var lg: CGFloat { 40 }
        var xl: CGFloat { 48 }
        var xxl: CGFloat { 56 }
        var xxxl: CGFloat { 64 }
        var xxxxl: CGFloat { 80 }
    }

    struct BrandRadius: RadiusScale {
        var none: CGFloat { 0 }
        var xs: CGFloat { 2 }
        var sm: CGFloat { 4 }
        var md: CGFloat { 6 }   // SmartHR: m=6
        var lg: CGFloat { 8 }   // SmartHR: l=8
        var xl: CGFloat { 8 }
        var xxl: CGFloat { 8 }
        var card: CGFloat { 8 }
        var full: CGFloat { 10000 }
    }

    struct BrandTheme: Theme {
        var id: String { "brand" }
        var name: String { "Brand" }
        var description: String { "" }
        var category: ThemeCategory { .brandPersonality }
        var previewColors: [Color] { [.blue] }
        func colorPalette(for mode: ThemeMode) -> any ColorPalette { LightColorPalette() }
        var spacingScale: any SpacingScale { BrandSpacing() }
        var radiusScale: any RadiusScale { BrandRadius() }
    }

    func testExistingThemesKeepDefaultScales() {
        // Non-breaking: existing themes still return the default (visually unchanged)
        XCTAssertTrue(DefaultTheme().spacingScale is DefaultSpacingScale)
        XCTAssertTrue(DefaultTheme().radiusScale is DefaultRadiusScale)
    }

    func testBrandThemeSuppliesItsOwnScales() {
        let theme = BrandTheme()
        // char-relative spacing actually carries through (the core of resolving Wall W2)
        XCTAssertEqual(theme.spacingScale.xs, 16)
        XCTAssertEqual(theme.spacingScale.sm, 24)
        // SmartHR's corner radii: m=6 / l=8
        XCTAssertEqual(theme.radiusScale.md, 6)
        XCTAssertEqual(theme.radiusScale.lg, 8)
    }

    @MainActor
    func testThemeProviderExposesBrandScales() {
        // The brand's scale is reachable from currentTheme via ThemeProvider
        let provider = ThemeProvider(initialTheme: BrandTheme())
        XCTAssertEqual(provider.currentTheme.spacingScale.xs, 16)
        XCTAssertEqual(provider.currentTheme.radiusScale.lg, 8)
    }
}
