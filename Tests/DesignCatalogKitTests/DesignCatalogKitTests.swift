import XCTest
import SwiftUI
import DesignSystem
@testable import DesignCatalogKit

/// Verifies CatalogKit's pure logic (no UI dependency): diff calculation and grouping are correct.
final class DesignCatalogKitTests: XCTestCase {

    /// A test theme whose type scale differs from the default
    struct BigTypeScale: TypographyScale {
        func style(for role: Typography) -> TypeStyle {
            TypeStyle(size: 99, weight: .bold, leadingMultiplier: 2.0)
        }
    }
    struct ThemeA: Theme {
        var id: String { "a" }; var name: String { "A" }; var description: String { "" }
        var category: ThemeCategory { .standard }; var previewColors: [Color] { [.blue] }
        func colorPalette(for mode: ThemeMode) -> any ColorPalette { LightColorPalette() }
    }
    struct ThemeB: Theme {
        var id: String { "b" }; var name: String { "B" }; var description: String { "" }
        var category: ThemeCategory { .standard }; var previewColors: [Color] { [.red] }
        func colorPalette(for mode: ThemeMode) -> any ColorPalette { LightColorPalette() }
        var typographyScale: any TypographyScale { BigTypeScale() }
    }

    func testTypographyDiffDetectsDifferences() {
        let rows = TokenDiff.typography(ThemeA().typographyScale, ThemeB().typographyScale)
        XCTAssertEqual(rows.count, Typography.allCases.count)
        // B is 99pt×2.0 across every role, so all rows differ from the default.
        XCTAssertTrue(rows.allSatisfy { $0.differs })
        XCTAssertFalse(TokenDiff.differing(rows).isEmpty)
    }

    func testIdenticalThemesHaveNoDiff() {
        let rows = TokenDiff.spacing(ThemeA().spacingScale, ThemeA().spacingScale)
        XCTAssertTrue(TokenDiff.differing(rows).isEmpty, "Identical themes should produce no diff")
    }

    func testRadiusDiffRowFormatting() {
        let rows = TokenDiff.radius(ThemeA().radiusScale, ThemeA().radiusScale)
        XCTAssertTrue(rows.contains { $0.label == "full" })
        XCTAssertTrue(rows.allSatisfy { !$0.differs })
    }

    @MainActor
    func testEntriesGroupAndFilterByArchetype() {
        let entries: [CatalogEntry] = [
            entry(id: "1", archetype: "FormControl", brand: "x"),
            entry(id: "2", archetype: "FormControl", brand: "y"),
            entry(id: "3", archetype: "FocusIndicator", brand: "x"),
        ]
        let groups = entries.groupedByArchetype()
        XCTAssertEqual(groups.count, 2)
        // Sorted by archetype name: FocusIndicator < FormControl
        XCTAssertEqual(groups.first?.archetype, "FocusIndicator")
        XCTAssertEqual(entries.entries(ofArchetype: "FormControl").count, 2)
    }

    @MainActor
    private func entry(id: String, archetype: String, brand: String) -> CatalogEntry {
        CatalogEntry(
            id: id, brandId: brand, brandName: brand, archetype: archetype, title: archetype,
            annotation: DesignAnnotation(purpose: "p", whyItWorks: "w"),
            theme: ThemeA()
        ) { Text("x") }
    }
}
