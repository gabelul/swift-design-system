import SwiftUI

/// Stroke-width scale. Tokenizes stroke widths for borders, dividers, focus-ring outlines, and the like.
///
/// Previously, values like `lineWidth: 1` were scattered across individual components. Line weight
/// varies significantly by brand (SmartHR mostly uses 1px, with a 2px+2px double ring for focus), so
/// we abstract it here.
public protocol BorderScale: Sendable {
    /// 0
    var none: CGFloat { get }
    /// Hairline (0.5)
    var thin: CGFloat { get }
    /// Regular (1)
    var regular: CGFloat { get }
    /// Emphasized (2)
    var thick: CGFloat { get }
    /// Focus ring, etc. (4)
    var heavy: CGFloat { get }
}

public struct DefaultBorderScale: BorderScale {
    public init() {}
    public var none: CGFloat { 0 }
    public var thin: CGFloat { 0.5 }
    public var regular: CGFloat { 1 }
    public var thick: CGFloat { 2 }
    public var heavy: CGFloat { 4 }
}
