import SwiftUI
import DesignSystem

/// The token diff between two themes. An insight instrument in its own right — it puts a number
/// on "why this company's tokens differ from that one's." Pure logic with no UI dependency, so
/// it's fully unit-testable.
public enum TokenDiff {

    public struct Row: Sendable, Equatable, Identifiable {
        public var id: String { label }
        public var label: String
        public var a: String
        public var b: String
        public var differs: Bool

        public init(label: String, a: String, b: String) {
            self.label = label
            self.a = a
            self.b = b
            self.differs = a != b
        }
    }

    /// Typography diff (size × leading for every role).
    public static func typography(_ a: any TypographyScale, _ b: any TypographyScale) -> [Row] {
        Typography.allCases.map { role in
            let sa = a.style(for: role)
            let sb = b.style(for: role)
            return Row(
                label: String(describing: role),
                a: fmt(sa.size, sa.leadingMultiplier),
                b: fmt(sb.size, sb.leadingMultiplier)
            )
        }
    }

    /// Spacing diff.
    public static func spacing(_ a: any SpacingScale, _ b: any SpacingScale) -> [Row] {
        let items: [(String, CGFloat, CGFloat)] = [
            ("none", a.none, b.none), ("xxs", a.xxs, b.xxs), ("xs", a.xs, b.xs),
            ("sm", a.sm, b.sm), ("md", a.md, b.md), ("lg", a.lg, b.lg),
            ("xl", a.xl, b.xl), ("xxl", a.xxl, b.xxl), ("xxxl", a.xxxl, b.xxxl),
            ("xxxxl", a.xxxxl, b.xxxxl),
        ]
        return items.map { Row(label: $0.0, a: num($0.1), b: num($0.2)) }
    }

    /// Radius diff.
    public static func radius(_ a: any RadiusScale, _ b: any RadiusScale) -> [Row] {
        let items: [(String, CGFloat, CGFloat)] = [
            ("none", a.none, b.none), ("xs", a.xs, b.xs), ("sm", a.sm, b.sm),
            ("md", a.md, b.md), ("lg", a.lg, b.lg), ("xl", a.xl, b.xl),
            ("xxl", a.xxl, b.xxl), ("card", a.card, b.card), ("full", a.full, b.full),
        ]
        return items.map { Row(label: $0.0, a: num($0.1), b: num($0.2)) }
    }

    /// Only the rows that differ (the insight summary).
    public static func differing(_ rows: [Row]) -> [Row] { rows.filter(\.differs) }

    private static func fmt(_ size: CGFloat, _ leading: CGFloat) -> String {
        "\(num(size))pt ×\(String(format: "%.2f", leading))"
    }
    private static func num(_ v: CGFloat) -> String {
        guard v.isFinite else { return "∞" }
        if v != v.rounded() { return String(format: "%.1f", v) }
        // Guards against Int() trapping on huge values (e.g. rounding/overflow from `full`'s .infinity).
        if abs(v) > 1e9 { return String(format: "%.0f", v) }
        return String(Int(v))
    }
}
