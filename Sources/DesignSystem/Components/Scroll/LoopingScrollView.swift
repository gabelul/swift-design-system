import SwiftUI
import Combine

/// 無限ループ + 自動スクロールする横スクロールビュー。
///
/// 末尾に到達すると先頭へシームレスに巻き戻り、タイマーで自動的に流れ続ける。
/// `scrollingSpeed` を負にすると逆方向に流れる。ユーザーのドラッグ操作も共存できる。
///
/// 出典: Kavsoft "Apple Stocks UI Animation: Auto Scroll & Looping ScrollView" (2026-01)
@available(iOS 18.0, macOS 15.0, *)
public struct LoopingScrollView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    public var spacing: CGFloat
    /// 1 tick (0.01s) あたりのスクロール量。負で逆方向。
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
                // オリジナル
                HStack(spacing: spacing) {
                    ForEach(data) { item in
                        content(item, false)
                            .frame(width: itemWidth)
                    }
                }

                // ループを成立させるための繰り返し分
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
        // コンテナ幅から必要な繰り返し数を計算
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

            // 進行中のスクロールを乱さずに巻き戻す
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
        // 自動スクロール
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .default).autoconnect()) { _ in
            let target = currentOffset + scrollingSpeed
            // 逆方向はオフセット 0 でクランプされ `newValue < 0` の巻き戻しが
            // 発火しないため（出典実装の穴）、端に達する前にこちらで折り返す。
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
