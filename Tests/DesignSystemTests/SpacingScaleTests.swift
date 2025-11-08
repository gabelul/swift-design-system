import XCTest
@testable import DesignSystem

final class SpacingScaleTests: XCTestCase {
    func testDefaultSpacingScale() {
        let spacing = DefaultSpacingScale()

        // 正しい値が設定されているか確認
        XCTAssertEqual(spacing.none, 0)
        XCTAssertEqual(spacing.xxs, 2)
        XCTAssertEqual(spacing.xs, 4)
        XCTAssertEqual(spacing.sm, 8)
        XCTAssertEqual(spacing.md, 12)
        XCTAssertEqual(spacing.lg, 16)
        XCTAssertEqual(spacing.xl, 24)
        XCTAssertEqual(spacing.xxl, 32)
        XCTAssertEqual(spacing.xxxl, 48)
        XCTAssertEqual(spacing.xxxxl, 64)
    }

    func testSpacingProgression() {
        let spacing = DefaultSpacingScale()

        // スペーシングが正しく増加しているか確認
        XCTAssertLessThan(spacing.none, spacing.xxs)
        XCTAssertLessThan(spacing.xxs, spacing.xs)
        XCTAssertLessThan(spacing.xs, spacing.sm)
        XCTAssertLessThan(spacing.sm, spacing.md)
        XCTAssertLessThan(spacing.md, spacing.lg)
        XCTAssertLessThan(spacing.lg, spacing.xl)
        XCTAssertLessThan(spacing.xl, spacing.xxl)
        XCTAssertLessThan(spacing.xxl, spacing.xxxl)
        XCTAssertLessThan(spacing.xxxl, spacing.xxxxl)
    }
}
