import SwiftUI
import XCTest
@testable import DesignSystem

/// Covers `TypographyProvider` as a `TypographyScale` (upstream v1.7.0 model):
/// custom font families, global scale, and the fork's serif-token policy.
final class TypographyProviderTests: XCTestCase {
    func testResolvesSystemFontWhenNoFamiliesConfigured() {
        let provider = TypographyProvider()

        XCTAssertEqual(provider.style(for: .bodyMedium).fontResource, .system)
        XCTAssertNil(provider.style(for: .bodyMedium).design)
    }

    func testSansFamilyAppliesToNonSerifTokens() {
        let provider = TypographyProvider(sansFontName: "Inter")

        XCTAssertEqual(provider.style(for: .bodyMedium).fontResource, .named("Inter"))
    }

    func testSerifTokensRenderSystemSerifWhenNoSerifFontConfigured() {
        let provider = TypographyProvider(serifTokens: [.displaySmall])

        let serif = provider.style(for: .displaySmall)
        XCTAssertEqual(serif.fontResource, .system)
        XCTAssertEqual(serif.design, .serif)

        // A token outside the serif set stays sans.
        XCTAssertNil(provider.style(for: .bodyMedium).design)
    }

    func testSerifFontNameAppliesToSerifTokens() {
        let provider = TypographyProvider(
            sansFontName: "Inter",
            serifFontName: "SourceSerif4",
            serifTokens: [.displaySmall]
        )

        XCTAssertEqual(provider.style(for: .displaySmall).fontResource, .named("SourceSerif4"))
        XCTAssertEqual(provider.style(for: .bodyMedium).fontResource, .named("Inter"))
    }

    func testScaleMultipliesSize() {
        let provider = TypographyProvider(scale: 1.25)

        XCTAssertEqual(
            provider.style(for: .headlineMedium).size,
            Typography.headlineMedium.size * 1.25,
            accuracy: 0.001
        )
        XCTAssertEqual(
            provider.style(for: .labelSmall).size,
            Typography.labelSmall.size * 1.25,
            accuracy: 0.001
        )
    }
}
