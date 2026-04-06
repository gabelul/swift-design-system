import SwiftUI

/// A layout that arranges views horizontally, wrapping to the next line when space runs out
///
/// Perfect for tag lists, filter chips, keyword badges, or any collection of
/// variable-width items that should flow naturally like text.
///
/// ## Usage
/// ```swift
/// FlowLayout(spacing: 8) {
///     ForEach(tags, id: \.self) { tag in
///         Chip(tag)
///     }
/// }
/// ```
///
/// ## Design Guidelines
/// - Use `spacing` of 8pt for compact chip/tag layouts
/// - Use `spacing` of 12–16pt for more spacious card-based layouts
/// - Items wrap based on available width — works naturally in ScrollView and fixed containers
public struct FlowLayout: Layout {
    /// Spacing between items and between rows
    public var spacing: CGFloat

    /// Creates a flow layout with the specified spacing
    ///
    /// - Parameter spacing: Gap between items horizontally and between rows vertically (default: 8pt)
    public init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }

    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }

    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            let frame = result.frames[index]
            subview.place(
                at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY),
                proposal: .unspecified
            )
        }
    }
}

// MARK: - Internal Layout Calculation

private struct FlowResult {
    let size: CGSize
    let frames: [CGRect]

    init(in maxWidth: CGFloat, subviews: LayoutSubviews, spacing: CGFloat) {
        var frames: [CGRect] = []
        var currentRowY: CGFloat = 0
        var currentRowWidth: CGFloat = 0
        var currentRowHeight: CGFloat = 0

        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)

            // Wrap to next row if this item would exceed available width
            if currentRowWidth + subviewSize.width > maxWidth && !frames.isEmpty {
                currentRowY += currentRowHeight + spacing
                currentRowWidth = 0
                currentRowHeight = 0
            }

            frames.append(
                CGRect(origin: CGPoint(x: currentRowWidth, y: currentRowY), size: subviewSize)
            )

            currentRowWidth += subviewSize.width + spacing
            currentRowHeight = max(currentRowHeight, subviewSize.height)
        }

        self.frames = frames
        self.size = CGSize(width: maxWidth, height: currentRowY + currentRowHeight)
    }
}
