import XCTest
import SwiftUI
@testable import DesignSystem

/// Verifies G3: the new border / stateLayer / gradient / elevation override tokens
/// are added and that a brand can override and carry them through a theme.
final class NewTokenTests: XCTestCase {

    func testDefaultsExistAndAreReasonable() {
        XCTAssertEqual(DefaultBorderScale().regular, 1)
        XCTAssertEqual(DefaultStateLayer().hover, 0.08)
        // The elevation default is derived from the existing enum (visual parity)
        XCTAssertEqual(DefaultElevationScale().style(for: .level2).radius, Elevation.level2.radius)
        XCTAssertEqual(DefaultElevationScale().style(for: .level2).opacity, Elevation.level2.opacity, accuracy: 0.0001)
    }

    func testGradientTokenProducesLinearGradient() {
        let token = GradientToken(colors: [.red, .blue], startPoint: .top, endPoint: .bottom)
        XCTAssertEqual(token.colors.count, 2)
        _ = token.linearGradient // Confirm this constructs successfully
    }

    func testExistingThemesUseNewDefaults() {
        let theme = DefaultTheme()
        XCTAssertTrue(theme.borderScale is DefaultBorderScale)
        XCTAssertTrue(theme.stateLayer is DefaultStateLayer)
        XCTAssertTrue(theme.gradients is DefaultGradientTokens)
        XCTAssertTrue(theme.elevationScale is DefaultElevationScale)
    }

    func testBrandCanOverrideNewTokens() {
        struct FlatElevation: ElevationScale {
            // Flat design: disable all shadows
            func style(for level: Elevation) -> ElevationStyle {
                ElevationStyle(radius: 0, offset: .zero, opacity: 0)
            }
        }
        struct ThickBorder: BorderScale {
            var none: CGFloat { 0 }
            var thin: CGFloat { 1 }
            var regular: CGFloat { 2 }
            var thick: CGFloat { 4 }
            var heavy: CGFloat { 8 }
        }
        struct BrandTheme: Theme {
            var id: String { "brand" }
            var name: String { "Brand" }
            var description: String { "" }
            var category: ThemeCategory { .brandPersonality }
            var previewColors: [Color] { [.blue] }
            func colorPalette(for mode: ThemeMode) -> any ColorPalette { LightColorPalette() }
            var elevationScale: any ElevationScale { FlatElevation() }
            var borderScale: any BorderScale { ThickBorder() }
        }
        let theme = BrandTheme()
        // The flattened override carries through (the old enum was fixed — overridability is the whole point)
        XCTAssertEqual(theme.elevationScale.style(for: .level5).radius, 0)
        XCTAssertEqual(theme.borderScale.regular, 2)
    }
}
