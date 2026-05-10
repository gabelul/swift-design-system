import XCTest
@testable import DesignSystem

final class ScreenDensityTests: XCTestCase {
    func testAutomaticPaddingFollowsDensity() {
        let spacing = DefaultSpacingScale()

        XCTAssertEqual(ScreenPadding.automatic.resolvedVerticalPadding(spacing: spacing, density: .compact), spacing.lg)
        XCTAssertEqual(ScreenPadding.automatic.resolvedVerticalPadding(spacing: spacing, density: .standard), spacing.xl)
        XCTAssertEqual(ScreenPadding.automatic.resolvedVerticalPadding(spacing: spacing, density: .spacious), spacing.xxl)
    }

    func testSpaciousPaddingUsesExistingSemanticSpacing() {
        let spacing = DefaultSpacingScale()

        XCTAssertEqual(ScreenPadding.spacious.resolvedHorizontalPadding(spacing: spacing, density: .standard), spacing.xl)
        XCTAssertEqual(ScreenPadding.spacious.resolvedVerticalPadding(spacing: spacing, density: .standard), spacing.xxl)
    }

    func testCustomPaddingWinsOverDensity() {
        let spacing = DefaultSpacingScale()
        let padding = ScreenPadding.custom(horizontal: 18, vertical: 30)

        XCTAssertEqual(padding.resolvedHorizontalPadding(spacing: spacing, density: .compact), 18)
        XCTAssertEqual(padding.resolvedVerticalPadding(spacing: spacing, density: .spacious), 30)
    }
}
