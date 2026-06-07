import Foundation

/// コントロール寸法・状態のトークン
///
/// テーマに依存しない普遍値（HIG 由来など）を語彙として固定する。
/// テーマで変えたくなった時点で Semantic スケールへ昇格する。
public enum ControlTokens {
    /// タッチターゲットの最小辺（HIG: 44pt）。
    /// 円形ボタン・入力バーの高さなど、操作可能要素はこれを下回らない。
    public static let minTouchTarget: CGFloat = 44

    /// 無効状態の不透明度。disabled なコントロールの統一値。
    public static let disabledOpacity: Double = 0.5
}
