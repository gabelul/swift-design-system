import XCTest
import SwiftUI
@testable import DesignSystem

final class ColorHexTests: XCTestCase {
    func testHexInitialization6Digits() {
        let color = Color(hex: "#FF5733")
        XCTAssertNotNil(color)
    }

    func testHexInitializationWithoutHash() {
        let color = Color(hex: "FF5733")
        XCTAssertNotNil(color)
    }

    func testHexInitialization3Digits() {
        let color = Color(hex: "#F53")
        XCTAssertNotNil(color)
    }

    func testHexInitialization8Digits() {
        let color = Color(hex: "#FF5733AA")
        XCTAssertNotNil(color)
    }

    func testPrimitiveColorsAreValid() {
        // Verify primitive colors initialize correctly from hex
        XCTAssertNotNil(PrimitiveColors.blue500)
        XCTAssertNotNil(PrimitiveColors.gray900)
        XCTAssertNotNil(PrimitiveColors.red500)
        XCTAssertNotNil(PrimitiveColors.green500)
    }
}
