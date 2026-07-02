import Foundation

/// The default icon size scale.
///
/// Seven steps, referencing Material Design 3 / HIG recommended values.
public struct DefaultIconSizeScale: IconSizeScale {
    public init() {}

    public var xxs: CGFloat { 8 }
    public var xs: CGFloat { 12 }
    public var sm: CGFloat { 16 }
    public var md: CGFloat { 24 }
    public var lg: CGFloat { 32 }
    public var xl: CGFloat { 48 }
    public var xxl: CGFloat { 64 }
}
