import SwiftUI

public extension View {
    /// スケルトンローディング。redacted + softLight の光帯が横切る。
    ///
    /// 実コンテンツに `.skeleton(isRedacted: isLoading)` を付けるか、
    /// プレースホルダ用の Shape 群に付けて使う。
    /// 親ビューのアニメーショントランザクションに上書きされないよう内部でガードしている。
    ///
    /// 出典: Kavsoft "SwiftUI Skeleton View - Skeleton Loading Animations" (2025-04)
    /// - Parameters:
    ///   - isRedacted: スケルトン表示中かどうか。
    ///   - tint: 光帯の色。nil ならカラースキームに応じて白/黒。
    func skeleton(isRedacted: Bool, tint: Color? = nil) -> some View {
        modifier(SkeletonModifier(isRedacted: isRedacted, tint: tint))
    }
}

struct SkeletonModifier: ViewModifier {
    var isRedacted: Bool
    var tint: Color?
    @State private var isAnimating: Bool = false
    @Environment(\.colorScheme) private var scheme

    func body(content: Content) -> some View {
        content
            .redacted(reason: isRedacted ? .placeholder : [])
            .overlay {
                if isRedacted {
                    GeometryReader {
                        let size = $0.size
                        let skeletonWidth = size.width / 2
                        // ブラー半径は 30 以上を保証
                        let blurRadius = max(skeletonWidth / 2, 30)
                        let blurDiameter = blurRadius * 2
                        // 移動の端点
                        let minX = -(skeletonWidth + blurDiameter)
                        let maxX = size.width + skeletonWidth + blurDiameter

                        Rectangle()
                            .fill(tint ?? (scheme == .dark ? .white : .black))
                            .frame(width: skeletonWidth, height: size.height * 2)
                            .frame(height: size.height)
                            .blur(radius: blurRadius)
                            .rotationEffect(.degrees(rotation))
                            // 左 → 右へ無限に流す
                            .offset(x: isAnimating ? maxX : minX)
                    }
                    .mask {
                        content
                            .redacted(reason: .placeholder)
                    }
                    .blendMode(.softLight)
                    .task { @MainActor in
                        guard !isAnimating else { return }
                        withAnimation(animation) {
                            isAnimating = true
                        }
                    }
                    .onDisappear {
                        isAnimating = false
                    }
                    .transaction {
                        // 親のトランザクションが repeatForever を上書きするのを防ぐ
                        if $0.animation != animation {
                            $0.animation = .none
                        }
                    }
                }
            }
    }

    var rotation: Double { 5 }

    var animation: Animation {
        .easeInOut(duration: 1.5).repeatForever(autoreverses: false)
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        HStack(spacing: 12) {
            Circle().frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 6) {
                RoundedRectangle(cornerRadius: 4).frame(width: 140, height: 12)
                RoundedRectangle(cornerRadius: 4).frame(width: 90, height: 10)
            }
        }
        RoundedRectangle(cornerRadius: 12).frame(height: 120)
    }
    .foregroundStyle(.gray.opacity(0.3))
    .skeleton(isRedacted: true)
    .padding()
}
