import Foundation

/// Primitive spacing tokens
///
/// Defines base spacing values.
/// **Avoid direct use** — reference through `SpacingScale` protocol implementations instead.
///
/// ## Usage
/// ```swift
/// // Don't use directly
/// .padding(PrimitiveSpacing.space16)
///
/// // Preferred
/// @Environment(\.spacingScale) var spacing
/// .padding(spacing.lg)
/// ```
///
/// Reference in custom spacing scales:
/// ```swift
/// struct CustomSpacingScale: SpacingScale {
///     var lg: CGFloat { PrimitiveSpacing.space16 }
///     var xl: CGFloat { PrimitiveSpacing.space24 }
///     // ...
/// }
/// ```
public enum PrimitiveSpacing {
    public static let space0: CGFloat = 0
    public static let space2: CGFloat = 2
    public static let space4: CGFloat = 4
    public static let space8: CGFloat = 8
    public static let space12: CGFloat = 12
    public static let space16: CGFloat = 16
    public static let space20: CGFloat = 20
    public static let space24: CGFloat = 24
    public static let space32: CGFloat = 32
    public static let space40: CGFloat = 40
    public static let space48: CGFloat = 48
    public static let space64: CGFloat = 64
    public static let space80: CGFloat = 80
    public static let space96: CGFloat = 96
}
