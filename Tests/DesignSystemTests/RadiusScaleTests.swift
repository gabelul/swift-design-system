import XCTest
@testable import DesignSystem

final class RadiusScaleTests: XCTestCase {
    func testDefaultRadiusScale() {
        let radius = DefaultRadiusScale()

        // 正しい値が設定されているか確認
        XCTAssertEqual(radius.none, 0)
        XCTAssertEqual(radius.xs, 2)
        XCTAssertEqual(radius.sm, 4)
        XCTAssertEqual(radius.md, 8)
        XCTAssertEqual(radius.lg, 12)
        XCTAssertEqual(radius.xl, 16)
        XCTAssertEqual(radius.xxl, 20)
        XCTAssertEqual(radius.full, .infinity)
    }

    func testRadiusProgression() {
        let radius = DefaultRadiusScale()

        // 角丸が正しく増加しているか確認（fullを除く）
        XCTAssertLessThan(radius.none, radius.xs)
        XCTAssertLessThan(radius.xs, radius.sm)
        XCTAssertLessThan(radius.sm, radius.md)
        XCTAssertLessThan(radius.md, radius.lg)
        XCTAssertLessThan(radius.lg, radius.xl)
        XCTAssertLessThan(radius.xl, radius.xxl)
    }
}
