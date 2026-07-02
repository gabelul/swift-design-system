import SwiftUI
import Combine

/// A horizontal scroll view that loops infinitely and auto-scrolls.
///
/// Seamlessly wraps back to the start when it reaches the end, and keeps flowing
/// automatically via a timer. A negative `scrollingSpeed` reverses the direction.
/// User drag gestures can coexist with the auto-scroll.
///
/// Source: Kavsoft "Apple Stocks UI Animation: Auto Scroll & Looping ScrollView" (2026-01)
@available(iOS 18.0, macOS 15.0, *)
public struct LoopingScrollView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    public var spacing: CGFloat
    /// Scroll amount per tick (0.01s). Negative reverses direction.
    public var scrollingSpeed: CGFloat
    public var itemWidth: CGFloat
    public var data: Data
    @ViewBuilder public var content: (_ item: Data.Element, _ isRepeated: Bool) -> Content

    @State private var scrollPosition: ScrollPosition = .init()
    @State private var containerWidth: CGFloat = 0
    @State private var currentOffset: CGFloat = 0
    @State private var repeatingCount: Int = 0

    public init(
        spacing: CGFloat = 10,
        scrollingSpeed: CGFloat = 0.7,
        itemWidth: CGFloat,
        data: Data,
        @ViewBuilder content: @escaping (_ item: Data.Element, _ isRepeated: Bool) -> Content
    ) {
        self.spacing = spacing
        self.scrollingSpeed = scrollingSpeed
        self.itemWidth = itemWidth
        self.data = data
        self.content = content
    }

    public var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: spacing) {
                // Original items
                HStack(spacing: spacing) {
                    ForEach(data) { item in
                        content(item, false)
                            .frame(width: itemWidth)
                    }
                }

                // Repeated items needed to make the loop seamless
                HStack(spacing: spacing) {
                    ForEach(0..<repeatingCount, id: \.self) { index in
                        let actualIndex = index % data.count
                        let itemIndex = data.index(data.startIndex, offsetBy: actualIndex)

                        content(data[itemIndex], true)
                            .frame(width: itemWidth)
                    }
                }
            }
        }
        .scrollPosition($scrollPosition)
        .scrollIndicators(.hidden)
        // Calculate the required repeat count from the container width
        .onScrollGeometryChange(for: CGFloat.self) {
            $0.containerSize.width
        } action: { _, newValue in
            let containerWidth = newValue
            let safeValue: Int = 1
            let neededCount = (containerWidth / (itemWidth + spacing)).rounded()
            self.repeatingCount = Int(neededCount) + safeValue
            self.containerWidth = containerWidth
        }
        .onScrollGeometryChange(for: CGFloat.self) {
            $0.contentOffset.x + $0.contentInsets.leading
        } action: { _, newValue in
            currentOffset = newValue
            guard repeatingCount > 0 else { return }

            let contentWidth = CGFloat(data.count) * itemWidth
            let contentSpacing = CGFloat(data.count) * spacing
            let totalContentWidth = contentWidth + contentSpacing

            let resetOffset = min(totalContentWidth - newValue, 0)

            // Wrap back around without disrupting an in-flight scroll
            if resetOffset < 0 || newValue < 0 {
                var transaction = Transaction()
                transaction.scrollPositionUpdatePreservesVelocity = true

                withTransaction(transaction) {
                    if newValue < 0 {
                        scrollPosition.scrollTo(x: totalContentWidth)
                    } else {
                        scrollPosition.scrollTo(x: resetOffset)
                    }
                }
            }
        }
        // Auto-scroll
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .default).autoconnect()) { _ in
            let target = currentOffset + scrollingSpeed
            // Reverse direction clamps at offset 0 and never triggers the `newValue < 0`
            // wraparound above (a gap in the source implementation), so we wrap here
            // before it reaches the edge.
            if scrollingSpeed < 0, target <= 0, repeatingCount > 0, !data.isEmpty {
                let totalContentWidth = CGFloat(data.count) * (itemWidth + spacing)
                var transaction = Transaction()
                transaction.scrollPositionUpdatePreservesVelocity = true
                withTransaction(transaction) {
                    scrollPosition.scrollTo(x: totalContentWidth + target)
                }
            } else {
                scrollPosition.scrollTo(x: target)
            }
        }
    }
}
