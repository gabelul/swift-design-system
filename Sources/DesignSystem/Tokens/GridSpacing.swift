import Foundation

/// Grid layout spacing (gutter) token
///
/// Manages spacing between grid items uniformly.
/// Based on Material Design 3 and Fluent 2 guidelines,
/// providing appropriate spacing for different screen sizes and contexts.
///
/// ## Usage
/// ```swift
/// AspectGrid(
///     minItemWidth: 160,
///     maxItemWidth: 200,
///     itemAspectRatio: 2/3,
///     spacing: .md  // Default spacing
/// ) {
///     // Content
/// }
/// ```
///
/// ## Design Guidelines
/// - Material Design 3: 16-24dp gutters
/// - Fluent 2: 8-16px gutters
/// - Apple HIG: 8-20pt spacing
/// - Follows 8pt grid system
public enum GridSpacing: CGFloat, Sendable {
    /// Minimum spacing (8pt)
    ///
    /// Best for dense layouts and small items.
    ///
    /// ## Use cases
    /// - Icon grids
    /// - Tag lists
    /// - Compact thumbnails
    case xs = 8

    /// Small spacing (12pt)
    ///
    /// Best for compact layouts.
    ///
    /// ## Use cases
    /// - Card grids (compact)
    /// - Thumbnail lists
    /// - Dense galleries
    case sm = 12

    /// Standard spacing (16pt)
    ///
    /// Default spacing. Suitable for most grid layouts.
    ///
    /// ## Use cases
    /// - Book covers
    /// - Product listings
    /// - Photo grids
    case md = 16

    /// Large spacing (20pt)
    ///
    /// Best for spacious layouts.
    ///
    /// ## Use cases
    /// - Card grids (regular)
    /// - Media galleries
    /// - Featured content
    case lg = 20

    /// Maximum spacing (24pt)
    ///
    /// Best for very spacious layouts and large items.
    ///
    /// ## Use cases
    /// - Hero cards
    /// - Feature grids
    /// - Premium content
    case xl = 24

    /// CGFloat value
    public var value: CGFloat {
        self.rawValue
    }
}
