import XCTest
import SwiftUI
@testable import DesignSystem

/// Verifies the Dynamic Type scaling that backs `.typography(_:)`.
///
/// The regression this guards: the ramp used to be fixed-size, so text never
/// grew with the user's text-size setting. `TypographyScaling.scaledSize` now
/// scales the base point size — unchanged at the default size, larger at
/// accessibility sizes.
final class TypographyScalingTests: XCTestCase {

    /// At the default text size, scaling is a no-op — the base ramp is preserved.
    func testDefaultSizeIsUnchanged() {
        for role in Typography.allCases {
            let scaled = TypographyScaling.scaledSize(
                role.size,
                textStyle: role.relativeTextStyle,
                dynamicTypeSize: .large // `.large` is the system default
            )
            XCTAssertEqual(scaled, role.size, accuracy: 0.5,
                           "\(role) should render at its base size at the default text size")
        }
    }

    /// Accessibility sizes must be strictly larger than the default — this is the
    /// exact bug we fixed (default and accessibility-large were pixel-identical).
    /// Guarded: scaling is UIFontMetrics-backed, so it's a no-op off iOS.
    #if canImport(UIKit)
    func testAccessibilitySizesGrow() {
        for role in Typography.allCases where role.size > 0 {
            let base = TypographyScaling.scaledSize(role.size, textStyle: role.relativeTextStyle, dynamicTypeSize: .large)
            let a11yLarge = TypographyScaling.scaledSize(role.size, textStyle: role.relativeTextStyle, dynamicTypeSize: .accessibility2)
            let a11yMax = TypographyScaling.scaledSize(role.size, textStyle: role.relativeTextStyle, dynamicTypeSize: .accessibility5)

            XCTAssertGreaterThan(a11yLarge, base,
                                 "\(role) must grow at accessibility-large vs default")
            XCTAssertGreaterThanOrEqual(a11yMax, a11yLarge,
                                        "\(role) must not shrink from accessibility-large to the max size")
        }
    }

    /// Scaling increases monotonically across the standard-size ramp for body text.
    func testMonotonicAcrossStandardSizes() {
        let sizes: [DynamicTypeSize] = [.xSmall, .small, .medium, .large, .xLarge, .xxLarge, .xxxLarge]
        var previous: CGFloat = 0
        for size in sizes {
            let scaled = TypographyScaling.scaledSize(16, textStyle: .body, dynamicTypeSize: size)
            XCTAssertGreaterThanOrEqual(scaled, previous,
                                        "body text must not shrink as the text size increases (\(size))")
            previous = scaled
        }
    }
    #endif

    /// Every role maps to a text style — a compile+coverage guard so a new role
    /// can't silently ship without a scaling mapping.
    func testEveryRoleHasATextStyle() {
        for role in Typography.allCases {
            _ = role.relativeTextStyle // must not trap
        }
    }
}
