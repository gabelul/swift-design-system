import SwiftUI

/// The rendering style for a surface (a "plane" component like a card).
///
/// Switches, via the Environment, whether surface components — `Card` chief
/// among them — render as an opaque surface or as translucent Liquid Glass.
/// This is the mechanism for injecting the app's design language into
/// dynamically generated UI trees (e.g. A2UI rendering) without touching the
/// renderer.
///
/// ## Usage
/// ```swift
/// // Every Card underneath becomes a glass surface
/// A2UISurfaceView(surface)
///     .surfaceStyle(.glass)
/// ```
///
/// ## Automatic nesting demotion
/// Stacked glass turns murky and hurts readability, so `Card` automatically
/// tracks nesting depth and demotes cards at depth 1 or deeper to a "faint
/// tint surface." This keeps proximity-based grouping intact while reserving
/// the glass translucency for the top level only.
public enum SurfaceStyle: Sendable, Equatable {
    /// An opaque surface (the conventional rendering, based on elevation tokens).
    case solid
    /// Liquid Glass. Lets the background show through, with a gradient border for an edge highlight.
    case glass
    /// Emphasized glass. Uses a primary tint and a brighter border to stage a hero surface.
    case glassProminent
}

// MARK: - Environment

private struct SurfaceStyleKey: EnvironmentKey {
    static let defaultValue: SurfaceStyle = .solid
}

private struct CardNestingLevelKey: EnvironmentKey {
    static let defaultValue: Int = 0
}

extension EnvironmentValues {
    /// The rendering style for surface components. Defaults to `.solid` (the conventional rendering).
    public var surfaceStyle: SurfaceStyle {
        get { self[SurfaceStyleKey.self] }
        set { self[SurfaceStyleKey.self] = newValue }
    }

    /// Card nesting depth. `Card` automatically increments this by 1 as it propagates to content.
    /// Under the glass style, cards at depth 1 or deeper are automatically demoted to a tint surface.
    public var cardNestingLevel: Int {
        get { self[CardNestingLevelKey.self] }
        set { self[CardNestingLevelKey.self] = newValue }
    }
}

public extension View {
    /// Switches the rendering style of surface components underneath (e.g. `Card`).
    ///
    /// - Parameter style: The ``SurfaceStyle`` to apply.
    func surfaceStyle(_ style: SurfaceStyle) -> some View {
        environment(\.surfaceStyle, style)
    }
}
