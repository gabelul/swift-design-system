import XCTest
import SwiftUI
@testable import DesignSystem

/// Verifies G1: the wall (W1) caused by Typography being a fixed enum is removed,
/// confirming brands can swap in their own type ramp (size and leading are separable).
final class TypographyScaleTests: XCTestCase {

    func testDefaultScaleReproducesEnumValues() {
        let scale = DefaultTypographyScale()
        // Derived from the existing enum values, so visual parity is preserved
        let style = scale.style(for: .bodyMedium)
        XCTAssertEqual(style.size, Typography.bodyMedium.size)
        XCTAssertEqual(style.weight, Typography.bodyMedium.weight)
        XCTAssertEqual(style.lineHeight, Typography.bodyMedium.lineHeight, accuracy: 0.01)
    }

    func testCustomScaleSeparatesSizeAndLeading() {
        // SmartHR-style: 16pt body x 1.5 leading (impossible to express with the old enum)
        struct SmartHRLikeScale: TypographyScale {
            func style(for role: Typography) -> TypeStyle {
                switch role {
                case .bodyMedium:
                    return TypeStyle(size: 16, weight: .regular, leadingMultiplier: 1.5)
                default:
                    return DefaultTypographyScale().style(for: role)
                }
            }
        }
        let style = SmartHRLikeScale().style(for: .bodyMedium)
        XCTAssertEqual(style.size, 16)
        XCTAssertEqual(style.leadingMultiplier, 1.5)
        XCTAssertEqual(style.lineHeight, 24, accuracy: 0.01) // 16 * 1.5
    }

    func testThemeSuppliesTypographyScaleWithDefault() {
        // Existing themes don't need to override this — default is returned (non-breaking)
        XCTAssertTrue(DefaultTheme().typographyScale is DefaultTypographyScale)

        // Brand themes can override typographyScale to inject their own type
        struct BrandScale: TypographyScale {
            func style(for role: Typography) -> TypeStyle {
                TypeStyle(size: 99, weight: .bold, leadingMultiplier: 1.5)
            }
        }
        struct BrandTheme: Theme {
            var id: String { "brand" }
            var name: String { "Brand" }
            var description: String { "" }
            var category: ThemeCategory { .brandPersonality }
            var previewColors: [Color] { [.blue] }
            func colorPalette(for mode: ThemeMode) -> any ColorPalette { LightColorPalette() }
            var typographyScale: any TypographyScale { BrandScale() }
        }
        XCTAssertEqual(BrandTheme().typographyScale.style(for: .bodyMedium).size, 99)
    }

    func testFontResourceSystemIsDefault() {
        // specified-but-not-bundled defaults to system delegation
        let style = TypeStyle(size: 16, weight: .regular, leadingMultiplier: 1.5)
        XCTAssertEqual(style.fontResource, .system)
    }
}
