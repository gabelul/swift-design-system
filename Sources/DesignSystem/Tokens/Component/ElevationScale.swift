import SwiftUI

/// A shadow style resolved for a given level.
public struct ElevationStyle: Sendable, Equatable {
    public var radius: CGFloat
    public var offset: CGSize
    public var opacity: Double

    public init(radius: CGFloat, offset: CGSize, opacity: Double) {
        self.radius = radius
        self.offset = offset
        self.opacity = opacity
    }

    /// Keep shadows subtle in dark mode (depth comes from surface brightness differences instead).
    public func opacity(for colorScheme: ColorScheme) -> Double {
        colorScheme == .dark ? opacity * 0.55 : opacity
    }
}

/// Maps an Elevation level to a shadow style. Themes can override this to swap shadow weight
/// (letting a brand choose flat vs. heavy — the previous fixed ``Elevation`` enum couldn't do this).
public protocol ElevationScale: Sendable {
    func style(for level: Elevation) -> ElevationStyle
}

/// The default shadow ramp. Derived **from the existing ``Elevation`` enum values**, so there's zero visual regression.
public struct DefaultElevationScale: ElevationScale {
    public init() {}
    public func style(for level: Elevation) -> ElevationStyle {
        ElevationStyle(radius: level.radius, offset: level.offset, opacity: level.opacity)
    }
}
