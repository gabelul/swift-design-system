import SwiftUI

/// The "type ramp" a theme supplies: a mapping from role (``Typography``) to
/// resolved style (``TypeStyle``).
///
/// The ``Typography`` enum used to hardcode its values, so a brand couldn't swap
/// the type (the biggest missing abstraction). This protocol moves the
/// value-supplying responsibility to the theme side: `.typography(.bodyMedium)`
/// call sites stay identical, but resolution goes through the Environment.
///
/// ``Typography`` remains as the "role selector," so existing call sites need no
/// changes.
public protocol TypographyScale: Sendable {
    /// Returns the resolved style for a role.
    func style(for role: Typography) -> TypeStyle
}

/// A type style resolved for a role. Keeps `size` and `leading` (line-height
/// multiplier) separate so CJK ramps like "body 16pt × leading 1.5" are expressible.
public struct TypeStyle: Sendable, Equatable {
    /// Font size (pt).
    public var size: CGFloat
    /// Weight.
    public var weight: Font.Weight
    /// Line-height multiplier (line-height / size). 1.5 is the Japanese-text standard.
    public var leadingMultiplier: CGFloat
    /// Tracking (em). Usually nil for Japanese text.
    public var trackingEm: CGFloat?
    /// Font source (defaults to system delegation = specified-but-not-bundled).
    public var fontResource: FontResource
    /// Default font design applied when a call site doesn't pin one.
    ///
    /// This is how a scale expresses an editorial policy such as "the display tier
    /// is serif by default" without a bundled font: a `.system` resource with
    /// `design == .serif` renders the system serif (New York). A design passed at
    /// the call site always overrides this.
    public var design: Font.Design?

    public init(
        size: CGFloat,
        weight: Font.Weight,
        leadingMultiplier: CGFloat,
        trackingEm: CGFloat? = nil,
        fontResource: FontResource = .system,
        design: Font.Design? = nil
    ) {
        self.size = size
        self.weight = weight
        self.leadingMultiplier = leadingMultiplier
        self.trackingEm = trackingEm
        self.fontResource = fontResource
        self.design = design
    }

    /// Effective line height (pt).
    public var lineHeight: CGFloat { size * leadingMultiplier }

    /// Builds the SwiftUI Font. A call-site `design` overrides the style's default.
    public func font(design: Font.Design? = nil) -> Font {
        fontResource.font(size: size, weight: weight, design: design ?? self.design)
    }
}

/// Font source. To respect the legal constraints of OSS distribution, "specify a
/// font but don't bundle it" is a first-class case.
public enum FontResource: Sendable, Equatable {
    /// Delegates to system-ui (no bundled font). This is the default.
    case system
    /// A named font. **This package does not bundle font files.**
    /// If the host has the font it's used, otherwise it falls back to system.
    case named(String)

    /// Builds the SwiftUI Font.
    public func font(size: CGFloat, weight: Font.Weight, design: Font.Design?) -> Font {
        switch self {
        case .system:
            return .system(size: size, weight: weight, design: design ?? .default)
        case let .named(name):
            return .custom(name, size: size).weight(weight)
        }
    }
}

/// The default type ramp. **Derived from the existing ``Typography`` values**, so
/// with no theme applied — or with existing themes — the look matches the original
/// exactly (zero visual regression).
public struct DefaultTypographyScale: TypographyScale {
    public init() {}

    public func style(for role: Typography) -> TypeStyle {
        TypeStyle(
            size: role.size,
            weight: role.weight,
            leadingMultiplier: role.size > 0 ? role.lineHeight / role.size : 1,
            fontResource: .system
        )
    }
}
