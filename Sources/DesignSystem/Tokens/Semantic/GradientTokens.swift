import SwiftUI

/// A value representing a gradient as a first-class token. Holds a color array and direction, and produces a `LinearGradient`.
///
/// Revenue-driving apps (Instagram, Coinbase, Robinhood, etc.) lean heavily on gradients, but
/// previously these were defined inline inside individual components. We abstract them here as semantic gradients.
public struct GradientToken: Sendable, Equatable {
    public var colors: [Color]
    public var startPoint: UnitPoint
    public var endPoint: UnitPoint

    public init(colors: [Color], startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    public var linearGradient: LinearGradient {
        LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint)
    }
}

/// A set of semantic gradients. Brands plug in their own gradients here.
public protocol GradientTokens: Sendable {
    /// The brand's hero gradient
    var brand: GradientToken { get }
    /// A subdued gradient for surfaces (backgrounds)
    var surface: GradientToken { get }
    /// Accent
    var accent: GradientToken { get }
}

/// Default gradients. A placeholder for when no brand is specified (brands are expected to override this).
public struct DefaultGradientTokens: GradientTokens {
    public init() {}
    public var brand: GradientToken {
        GradientToken(colors: [PrimitiveColors.blue500, PrimitiveColors.purple500])
    }
    public var surface: GradientToken {
        GradientToken(colors: [PrimitiveColors.gray50, PrimitiveColors.gray100])
    }
    public var accent: GradientToken {
        GradientToken(colors: [PrimitiveColors.cyan500, PrimitiveColors.blue500])
    }
}
