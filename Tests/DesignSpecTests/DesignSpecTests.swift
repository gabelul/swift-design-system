import XCTest
@testable import DesignSpec

/// Validity checks for the DesignSpec schema.
/// Central claim: it can represent SmartHR's specifics without loss, and a JSON
/// round-trip produces an exact match (= it holds up as an exchange format for
/// ingesting the 315-brand corpus and for LLM generation).
final class DesignSpecTests: XCTestCase {

    func testJSONRoundTripIsLossless() throws {
        let original = SmartHRSpecFixture.spec

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        let data = try encoder.encode(original)
        let decoded = try JSONDecoder().decode(DesignSpec.self, from: data)

        XCTAssertEqual(original, decoded, "No data should be lost across a JSON round-trip")
    }

    func testCaptursWarmGreyPrimitives() {
        let spec = SmartHRSpecFixture.spec
        // Warm black (not pure black) is preserved
        XCTAssertEqual(spec.color.primitive(named: "BLACK")?.hex, "#030302")
        // Brand cyan and main blue can coexist as separate roles
        let brand = spec.color.roles.first { $0.role == "BRAND" }
        let main = spec.color.roles.first { $0.role == "MAIN" }
        XCTAssertEqual(brand?.ref, "SMARTHR_BLUE")
        XCTAssertEqual(main?.ref, "BLUE_100")
        XCTAssertNotEqual(brand?.ref, main?.ref, "BRAND and MAIN are distinct colors")
    }

    func testTypographySeparatesSizeAndLeading() {
        let typo = SmartHRSpecFixture.spec.typography
        // Preserves "body 16px x leading 1.5", which the existing enum couldn't express
        let bodyM = typo.ramp.first { $0.role == "M" }
        XCTAssertEqual(bodyM?.sizeRem, 1.0)
        XCTAssertEqual(typo.leading(named: bodyM!.leadingRef)?.multiplier, 1.5)
        // The harmonic model is recorded
        if case let .harmonic(base, scaleFactor) = typo.scaleModel {
            XCTAssertEqual(base, 1.0)
            XCTAssertEqual(scaleFactor, 6.0)
        } else {
            XCTFail("SmartHR should use a harmonic scale")
        }
    }

    func testSpacingIsCharRelative() {
        let spacing = SmartHRSpecFixture.spec.spacing
        guard case let .charRelative(basePx) = spacing.model else {
            return XCTFail("SmartHR's spacing is char-relative")
        }
        XCTAssertEqual(basePx, 8.0)
        // XS = multiplier 1.0 x charSize(16) = 16pt
        let xs = spacing.steps.first { $0.name == "XS" }
        XCTAssertEqual(xs?.value, 16)
        XCTAssertEqual(xs?.multiplier, 1.0)
    }

    func testFocusRingIsDoubleRing() {
        let ring = SmartHRSpecFixture.spec.elevation.focusRing
        XCTAssertEqual(ring?.doubleRing, true, "SmartHR's focus ring is a double ring")
        XCTAssertEqual(ring?.colorRef, "OUTLINE")
    }

    func testFontStackDefersToSystem() {
        // Can express "specified but not bundled" (avoids typeface licensing issues)
        XCTAssertTrue(SmartHRSpecFixture.spec.typography.fontStack.system)
    }

    func testComponentsCarryArchetypeAndAnnotation() {
        let comps = SmartHRSpecFixture.spec.components
        XCTAssertTrue(comps.contains { $0.archetype == "FocusIndicator" })
        // The suggestive annotation (why) isn't empty = it carries fuel for comparison and learning
        XCTAssertTrue(comps.allSatisfy { !$0.annotation.isEmpty })
    }
}
