import SwiftUI

public extension View {
    /// 45 度に傾いた光沢の帯がビューを横切るシャインエフェクト。
    ///
    /// `trigger` の変化ごとに 1 回走る。連続で光らせたい場合は呼び出し側で
    /// 一定間隔で `trigger` をトグルする。
    ///
    /// 出典: Kavsoft "SwiftUI Shine Effect - Custom View Modifier" (2023-11)
    @ViewBuilder
    func shine(_ toggle: Bool, duration: CGFloat = 0.5, clipShape: some Shape = .rect, rightToLeft: Bool = false) -> some View {
        self
            .overlay {
                GeometryReader {
                    let size = $0.size
                    // 負・極小の duration を排除
                    let moddedDuration = max(0.3, duration)
                    // 45° 回転 + scaleEffect(y: 8) で帯の対角が伸びるため、
                    // 退避距離は幅だけでなく高さも足す（縦長ビューでの残留を防ぐ。出典からの修正点）
                    let travel = size.width + size.height

                    Rectangle()
                        .fill(.linearGradient(
                            colors: [
                                .clear,
                                .clear,
                                .white.opacity(0.1),
                                .white.opacity(0.5),
                                .white.opacity(1),
                                .white.opacity(0.5),
                                .white.opacity(0.1),
                                .clear,
                                .clear,
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .scaleEffect(y: 8)
                        .keyframeAnimator(initialValue: 0.0, trigger: toggle, content: { content, progress in
                            content
                                .offset(x: -travel + (progress * (travel * 2)))
                        }, keyframes: { _ in
                            CubicKeyframe(.zero, duration: 0.1)
                            CubicKeyframe(1, duration: moddedDuration)
                        })
                        .rotationEffect(.degrees(45))
                        .scaleEffect(x: rightToLeft ? -1 : 1)
                }
                .allowsHitTesting(false)
            }
            .clipShape(clipShape)
            .contentShape(clipShape)
    }
}
