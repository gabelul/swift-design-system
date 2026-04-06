import Foundation

/// Primitive radius tokens
///
/// Defines base corner radius values.
/// **Avoid direct use** — reference through `RadiusScale` protocol implementations instead.
///
/// ## Usage
/// ```swift
/// // Don't use directly
/// .cornerRadius(PrimitiveRadius.radius8)
///
/// // Preferred
/// @Environment(\.radiusScale) var radius
/// .cornerRadius(radius.md)
/// ```
///
/// Reference in custom radius scales:
/// ```swift
/// struct CustomRadiusScale: RadiusScale {
///     var md: CGFloat { PrimitiveRadius.radius8 }
///     var lg: CGFloat { PrimitiveRadius.radius12 }
///     // ...
/// }
/// ```
public enum PrimitiveRadius {
    public static let radius0: CGFloat = 0
    public static let radius2: CGFloat = 2
    public static let radius4: CGFloat = 4
    public static let radius6: CGFloat = 6
    public static let radius8: CGFloat = 8
    public static let radius12: CGFloat = 12
    public static let radius16: CGFloat = 16
    public static let radius20: CGFloat = 20
    public static let radius24: CGFloat = 24
    public static let radiusFull: CGFloat = .infinity
}
