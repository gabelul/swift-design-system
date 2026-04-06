import Foundation

/// Corner radius scale protocol
///
/// A scale system for providing consistent corner radii (border-radius).
/// Unifies corner radii across cards, buttons, input fields, and more.
///
/// ## Usage
/// ```swift
/// @Environment(\.radiusScale) var radius
///
/// RoundedRectangle(cornerRadius: radius.md)
///     .fill(Color.blue)
///     .frame(width: 100, height: 100)
///
/// // Or
/// Text("Button")
///     .padding()
///     .background(Color.blue)
///     .cornerRadius(radius.lg)
/// ```
///
/// ## Scale Reference
/// - `none`: 0pt - No corner radius (square)
/// - `xs`: 2pt - Smallest corner radius
/// - `sm`: 4pt - Small corner radius
/// - `md`: 8pt - Medium corner radius (recommended for cards)
/// - `lg`: 12pt - Large corner radius
/// - `xl`: 16pt - Very large corner radius
/// - `xxl`: 20pt - Extra large corner radius
/// - `full`: 9999pt - Fully circular (buttons, avatars, etc.)
public protocol RadiusScale: Sendable {
    /// No corner radius (0pt)
    var none: CGFloat { get }

    /// Smallest corner radius (2pt)
    var xs: CGFloat { get }

    /// Small corner radius (4pt)
    var sm: CGFloat { get }

    /// Medium corner radius (8pt) - recommended for cards
    var md: CGFloat { get }

    /// Large corner radius (12pt)
    var lg: CGFloat { get }

    /// Very large corner radius (16pt)
    var xl: CGFloat { get }

    /// Extra large corner radius (20pt)
    var xxl: CGFloat { get }

    /// Fully circular (9999pt) - buttons, avatars, etc.
    var full: CGFloat { get }
}
