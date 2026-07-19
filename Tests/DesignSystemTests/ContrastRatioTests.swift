import XCTest
import SwiftUI
@testable import DesignSystem

/// WCAG 2.1 contrast ratio verification.
///
/// `HighContrastTheme` declares itself "WCAG AAA compliant", so these tests
/// actually compute the contrast ratio of every foreground/background pair and
/// verify it against the 7.0 threshold (AAA for normal text). The threshold
/// itself is never relaxed.
final class ContrastRatioTests: XCTestCase {

    // MARK: - WCAG helpers

    private func components(_ color: Color) -> (red: Double, green: Double, blue: Double) {
        let resolved = color.resolve(in: EnvironmentValues())
        return (Double(resolved.red), Double(resolved.green), Double(resolved.blue))
    }

    /// WCAG 2.1 relative luminance. Gamma-expands the sRGB components and weights them by luminance coefficients
    private func relativeLuminance(_ color: Color) -> Double {
        func linearize(_ channel: Double) -> Double {
            channel <= 0.03928 ? channel / 12.92 : pow((channel + 0.055) / 1.055, 2.4)
        }
        let rgb = components(color)
        return 0.2126 * linearize(rgb.red)
            + 0.7152 * linearize(rgb.green)
            + 0.0722 * linearize(rgb.blue)
    }

    /// WCAG 2.1 contrast ratio (L1 + 0.05) / (L2 + 0.05). Ranges 1.0–21.0
    private func contrastRatio(_ foreground: Color, _ background: Color) -> Double {
        let a = relativeLuminance(foreground)
        let b = relativeLuminance(background)
        return (max(a, b) + 0.05) / (min(a, b) + 0.05)
    }

    private func assertContrastRatio(
        _ foreground: Color,
        _ background: Color,
        min minimum: Double,
        _ label: String,
        file: StaticString = #filePath, line: UInt = #line
    ) {
        let ratio = contrastRatio(foreground, background)
        XCTAssertGreaterThanOrEqual(
            ratio, minimum,
            "\(label): contrast ratio \(String(format: "%.2f", ratio)) is below the \(minimum) threshold",
            file: file, line: line
        )
    }

    /// WCAG 2.1 AAA threshold for normal text
    private let aaa = 7.0
    /// WCAG 2.1 AA threshold for normal text
    private let aa = 4.5

    // MARK: - Verifying the formula itself

    func testKnownContrastRatiosMatchTheWCAGFormula() {
        // Black on white is the theoretical maximum, 21:1
        XCTAssertEqual(contrastRatio(.black, .white), 21.0, accuracy: 0.01)
        // Identical colors are the minimum, 1:1
        XCTAssertEqual(contrastRatio(.white, .white), 1.0, accuracy: 0.001)
        // Swapping the order must not change the ratio
        XCTAssertEqual(contrastRatio(.white, .black), contrastRatio(.black, .white), accuracy: 0.001)
        // WCAG reference value: #767676 on white is exactly AA (4.54)
        XCTAssertEqual(contrastRatio(Color(hex: "#767676"), .white), 4.54, accuracy: 0.02)
    }

    // MARK: - HighContrast light mode

    func testHighContrastLightMeetsAAAOnTextSurfaces() {
        let palette = HighContrastLightPalette()

        assertContrastRatio(palette.onBackground, palette.background, min: aaa, "light onBackground/background")
        assertContrastRatio(palette.onSurface, palette.surface, min: aaa, "light onSurface/surface")
        assertContrastRatio(palette.onSurfaceVariant, palette.surfaceVariant, min: aaa, "light onSurfaceVariant/surfaceVariant")
        assertContrastRatio(palette.onPrimary, palette.primary, min: aaa, "light onPrimary/primary")
        assertContrastRatio(palette.onSecondary, palette.secondary, min: aaa, "light onSecondary/secondary")
        assertContrastRatio(palette.onPrimaryContainer, palette.primaryContainer, min: aaa, "light onPrimaryContainer/primaryContainer")
        assertContrastRatio(palette.onSecondaryContainer, palette.secondaryContainer, min: aaa, "light onSecondaryContainer/secondaryContainer")
        assertContrastRatio(palette.onSuccess, palette.success, min: aaa, "light onSuccess/success")
        assertContrastRatio(palette.onInfo, palette.info, min: aaa, "light onInfo/info")
    }

    func testHighContrastLightSemanticPairsMeetAAA() {
        let palette = HighContrastLightPalette()

        assertContrastRatio(palette.onTertiary, palette.tertiary, min: aaa, "light onTertiary/tertiary")
        assertContrastRatio(palette.onError, palette.error, min: aaa, "light onError/error")
        assertContrastRatio(palette.onWarning, palette.warning, min: aaa, "light onWarning/warning")
    }

    /// Light-mode semantic colors are also placed directly on the white background.
    /// Pin down that they keep AAA when used as text, not just as fills
    func testHighContrastLightSemanticColorsAreReadableOnBackground() {
        let palette = HighContrastLightPalette()

        assertContrastRatio(palette.error, palette.background, min: aaa, "light error/background")
        assertContrastRatio(palette.warning, palette.background, min: aaa, "light warning/background")
        assertContrastRatio(palette.success, palette.background, min: aaa, "light success/background")
        assertContrastRatio(palette.info, palette.background, min: aaa, "light info/background")
        assertContrastRatio(palette.tertiary, palette.background, min: aaa, "light tertiary/background")
    }

    // MARK: - HighContrast dark mode

    func testHighContrastDarkMeetsAAAOnTextSurfaces() {
        let palette = HighContrastDarkPalette()

        assertContrastRatio(palette.onBackground, palette.background, min: aaa, "dark onBackground/background")
        assertContrastRatio(palette.onSurface, palette.surface, min: aaa, "dark onSurface/surface")
        assertContrastRatio(palette.onSurfaceVariant, palette.surfaceVariant, min: aaa, "dark onSurfaceVariant/surfaceVariant")
        assertContrastRatio(palette.onPrimary, palette.primary, min: aaa, "dark onPrimary/primary")
        assertContrastRatio(palette.onSecondary, palette.secondary, min: aaa, "dark onSecondary/secondary")
        assertContrastRatio(palette.onTertiary, palette.tertiary, min: aaa, "dark onTertiary/tertiary")
        assertContrastRatio(palette.onPrimaryContainer, palette.primaryContainer, min: aaa, "dark onPrimaryContainer/primaryContainer")
        assertContrastRatio(palette.onSecondaryContainer, palette.secondaryContainer, min: aaa, "dark onSecondaryContainer/secondaryContainer")
        assertContrastRatio(palette.onWarning, palette.warning, min: aaa, "dark onWarning/warning")
    }

    func testHighContrastDarkSemanticPairsMeetAAA() {
        let palette = HighContrastDarkPalette()

        assertContrastRatio(palette.onError, palette.error, min: aaa, "dark onError/error")
        assertContrastRatio(palette.onSuccess, palette.success, min: aaa, "dark onSuccess/success")
        assertContrastRatio(palette.onInfo, palette.info, min: aaa, "dark onInfo/info")
    }

    /// Dark-mode semantic colors are also placed directly on the dark surface
    func testHighContrastDarkSemanticColorsAreReadableOnSurface() {
        let palette = HighContrastDarkPalette()

        assertContrastRatio(palette.error, palette.surface, min: aaa, "dark error/surface")
        assertContrastRatio(palette.warning, palette.surface, min: aaa, "dark warning/surface")
        assertContrastRatio(palette.success, palette.surface, min: aaa, "dark success/surface")
        assertContrastRatio(palette.info, palette.surface, min: aaa, "dark info/surface")
    }

    /// Guards against regressing to the unreadable "white text on a bright fill" combination.
    /// The default implementation's on-colors are .white, so this fails if an override is removed
    func testHighContrastDarkDoesNotFallBackToWhiteOnBrightFills() {
        let palette = HighContrastDarkPalette()

        for (name, color) in [
            ("onError", palette.onError),
            ("onSuccess", palette.onSuccess),
            ("onInfo", palette.onInfo),
            ("onTertiary", palette.onTertiary),
        ] {
            XCTAssertLessThan(
                relativeLuminance(color), 0.1,
                "\(name) sits on a bright fill and therefore must be a dark color"
            )
        }
    }

    // MARK: - Default theme (doesn't declare AAA, so verify against AA)

    func testDefaultThemeCoreTextPairsMeetAA() {
        let light = LightColorPalette()
        assertContrastRatio(light.onBackground, light.background, min: aa, "light onBackground/background")
        assertContrastRatio(light.onSurface, light.surface, min: aa, "light onSurface/surface")
        assertContrastRatio(light.onSurfaceVariant, light.surfaceVariant, min: aa, "light onSurfaceVariant/surfaceVariant")

        let dark = DarkColorPalette()
        assertContrastRatio(dark.onBackground, dark.background, min: aa, "dark onBackground/background")
        assertContrastRatio(dark.onSurface, dark.surface, min: aa, "dark onSurface/surface")
        assertContrastRatio(dark.onSurfaceVariant, dark.surfaceVariant, min: aa, "dark onSurfaceVariant/surfaceVariant")
    }

    func testHighContrastBeatsTheDefaultThemeOnBodyText() {
        // A theme calling itself "high contrast" must beat the default theme on body text
        let highContrast = contrastRatio(HighContrastLightPalette().onSurface, HighContrastLightPalette().surface)
        let standard = contrastRatio(LightColorPalette().onSurface, LightColorPalette().surface)
        XCTAssertGreaterThan(highContrast, standard)
    }

    // MARK: - Theme distinctiveness

    func testAllBuiltInThemesProduceDistinctPalettes() {
        // Tell themes apart by the resolved components of their primary color.
        // If two themes collapse into the same color, they can't be told apart in the picker
        var seen: [String: [Double]] = [:]
        for theme in ThemeRegistry.builtInThemes {
            let rgb = components(theme.colorPalette(for: .light).primary)
            let key = [rgb.red, rgb.green, rgb.blue]
            for (otherID, other) in seen {
                let delta = zip(key, other).reduce(0) { $0 + abs($1.0 - $1.1) }
                XCTAssertGreaterThan(delta, 0.01, "\(theme.id) and \(otherID) have the same primary color")
            }
            seen[theme.id] = key
        }
        XCTAssertEqual(seen.count, 7)
    }

    func testLightAndDarkPalettesDifferForEveryBuiltInTheme() {
        for theme in ThemeRegistry.builtInThemes {
            let light = components(theme.colorPalette(for: .light).background)
            let dark = components(theme.colorPalette(for: .dark).background)
            let delta = abs(light.red - dark.red) + abs(light.green - dark.green) + abs(light.blue - dark.blue)
            XCTAssertGreaterThan(delta, 0.1, "\(theme.id) has the same background in light and dark")
        }
    }
}
