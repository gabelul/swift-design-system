import SwiftUI

/// 文字スライス単位で blur + opacity + 縦オフセットが解けながら順次出現する TextRenderer。
///
/// `progress` を 0 → 1 にアニメーションさせて使う。
///
/// ```swift
/// Text("UI を組み上げています…")
///     .textRenderer(TitleTextRenderer(progress: progress))
///     .onAppear { withAnimation(.smooth(duration: 1.2)) { progress = 1 } }
/// ```
///
/// 出典: Kavsoft "Apple Invites App OnBoarding UI" (2025-02) CustomTextEffect.swift
@available(iOS 18.0, macOS 15.0, *)
public struct TitleTextRenderer: TextRenderer, Animatable {
    public var progress: CGFloat

    public init(progress: CGFloat) {
        self.progress = progress
    }

    public var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    public func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        let slices = layout.flatMap({ $0 }).flatMap({ $0 })

        for (index, slice) in slices.enumerated() {
            let sliceProgressIndex = CGFloat(slices.count) * progress
            let sliceProgress = max(min(sliceProgressIndex / CGFloat(index + 1), 1), 0)

            // コンテキストはループ間で累積させる（出典コメント準拠）
            ctx.addFilter(.blur(radius: 5 - (5 * sliceProgress)))
            ctx.opacity = sliceProgress
            ctx.translateBy(x: 0, y: 5 - (5 * sliceProgress))
            ctx.draw(slice, options: .disablesSubpixelQuantization)
        }
    }
}
