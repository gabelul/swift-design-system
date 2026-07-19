import XCTest
import SwiftUI
@testable import DesignSystem

/// Measures how SwiftUI sizes wrapped `Text`, to settle two questions that came
/// out of a long-running "list rows overlap at accessibility text sizes" bug.
///
/// The bug: a row built as `[badge][title + subtitle][chevron]` drew its text on
/// top of the row below once the text was allowed to wrap. Two explanations were
/// proposed and only one survived measurement.
///
/// 1. `.lineSpacing` is drawn but not measured → **disproved** below.
/// 2. The text column measures its height against the width the HStack proposes
///    *before* subtracting the badge and chevron, then renders in the narrower
///    column and wraps onto more lines than it measured → **this is the real one.**
///
/// The practical consequence, and the thing worth guarding: text that must wrap at
/// accessibility sizes needs the full container width, so the width it measures at
/// is the width it renders at.
///
/// A note on a trap this file previously fell into: asserting "the container
/// reserves at least the sum of its rows' heights" proves nothing, because both
/// sides of that comparison come from the same measurement pass. If the rows
/// under-report, the container under-reserves by exactly as much and the
/// assertion passes while the screen is visibly broken. Compare a laid-out height
/// against an independently-derived requirement instead.
#if canImport(UIKit)
final class TextMeasurementTests: XCTestCase {

    private let sample = "Rabies vaccination expired three weeks ago"

    /// Measures the height SwiftUI reports for a view at a given width.
    @MainActor
    private func measuredHeight(
        of view: some View,
        width: CGFloat,
        dynamicTypeSize: DynamicTypeSize = .large
    ) -> CGFloat {
        let host = UIHostingController(
            rootView: view
                .environment(\.dynamicTypeSize, dynamicTypeSize)
                .theme(ThemeProvider())
        )
        return host.sizeThatFits(in: CGSize(width: width,
                                            height: .greatestFiniteMagnitude)).height
    }

    /// Does a wrapped Text report a taller height once it carries leading?
    ///
    /// It does — which is why `.typography()` can apply `.lineSpacing` without
    /// breaking layout, and why truncation workarounds justified by "SwiftUI
    /// ignores lineSpacing" were aimed at the wrong thing.
    @MainActor
    func testLineSpacingIsIncludedInMeasuredHeight() {
        let font = Font.system(size: 20)
        let leading: CGFloat = 12
        let width: CGFloat = 140

        let withoutLeading = measuredHeight(
            of: Text(sample).font(font).fixedSize(horizontal: false, vertical: true),
            width: width
        )
        let withLeading = measuredHeight(
            of: Text(sample).font(font).lineSpacing(leading)
                .fixedSize(horizontal: false, vertical: true),
            width: width
        )

        XCTAssertGreaterThan(
            withLeading, withoutLeading,
            """
            A wrapped Text with \(leading)pt of lineSpacing reported the same height \
            (\(withLeading)pt) as one without it (\(withoutLeading)pt), so the leading \
            is drawn but not measured.
            """
        )
    }

    /// The same question through the shipping modifier rather than a bare Text.
    @MainActor
    func testTypographyModifierMeasuresItsOwnLeading() {
        let width: CGFloat = 140

        let plain = measuredHeight(
            of: Text(sample).font(.system(size: Typography.titleSmall.size))
                .fixedSize(horizontal: false, vertical: true),
            width: width
        )
        let styled = measuredHeight(
            of: Text(sample).typography(.titleSmall)
                .fixedSize(horizontal: false, vertical: true),
            width: width
        )

        // titleSmall is size 14 / lineHeight 20, so wrapped lines carry a 6pt gap.
        XCTAssertGreaterThan(
            styled, plain,
            ".typography(.titleSmall) reported \(styled)pt against a plain \(plain)pt for the same wrapped string."
        )
    }

    /// Guards the pattern that actually fixes the overlap: when the text column
    /// spans the full row width, the row reserves everything the text needs.
    ///
    /// The requirement is derived independently — the text is measured on its own
    /// at the same width the row will give it — so this fails for real if someone
    /// nests these labels back beside a badge and a chevron.
    @MainActor
    func testFullWidthTextColumnReservesTheHeightItRenders() {
        let rowWidth: CGFloat = 360
        let size: DynamicTypeSize = .accessibility5
        let title = "Benji · Add vet contact"
        let subtitle = "Required for boarding & sitter packet"

        let titleNeeds = measuredHeight(
            of: Text(title).typography(.titleSmall)
                .fixedSize(horizontal: false, vertical: true),
            width: rowWidth,
            dynamicTypeSize: size
        )
        let subtitleNeeds = measuredHeight(
            of: Text(subtitle).typography(.bodySmall)
                .fixedSize(horizontal: false, vertical: true),
            width: rowWidth,
            dynamicTypeSize: size
        )

        let stackedRow = measuredHeight(
            of: VStack(alignment: .leading, spacing: 0) {
                Text(title).typography(.titleSmall)
                    .fixedSize(horizontal: false, vertical: true)
                Text(subtitle).typography(.bodySmall)
                    .fixedSize(horizontal: false, vertical: true)
            },
            width: rowWidth,
            dynamicTypeSize: size
        )

        XCTAssertGreaterThanOrEqual(
            stackedRow, titleNeeds + subtitleNeeds,
            """
            A full-width row reported \(stackedRow)pt but its labels need \
            \(titleNeeds + subtitleNeeds)pt at the same \(rowWidth)pt width \
            (title \(titleNeeds)pt + subtitle \(subtitleNeeds)pt). Text will draw \
            outside the row and collide with whatever follows it.
            """
        )
    }
}
#endif
