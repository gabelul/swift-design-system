import Foundation

/// Icon size scale protocol.
///
/// Tokenizes the display size of SF Symbols / emoji / images.
/// This has a different responsibility from `Typography` (text) and `SpacingScale` (whitespace) — an
/// icon's size is a "visual element size" with its own scale, independent of text lineHeight or spacing.
///
/// ## Usage
/// ```swift
/// @Environment(\.iconSizeScale) var iconSize
///
/// Image(systemName: "checkmark")
///     .iconSize(.sm)          // inline icon next to body text
///
/// Image(systemName: "star.fill")
///     .iconSize(.lg)          // section header icon
///
/// Image(systemName: "sparkles")
///     .iconSize(.xl)          // hero icon (onboarding / empty state)
/// ```
///
/// ## Scale Reference
/// - `xxs`: 8pt - Tiny badge
/// - `xs`: 12pt - badge indicator / decoration
/// - `sm`: 16pt - inline icon next to body text
/// - `md`: 24pt - Standard icon (recommended default)
/// - `lg`: 32pt - Subheading or category icon
/// - `xl`: 48pt - Hero icon (section header / empty state)
/// - `xxl`: 64pt - Display icon (onboarding welcome, etc.)
public protocol IconSizeScale: Sendable {
    /// Tiny (8pt)
    var xxs: CGFloat { get }

    /// Smallest (12pt)
    var xs: CGFloat { get }

    /// Small (16pt) - body inline
    var sm: CGFloat { get }

    /// Medium (24pt) - standard
    var md: CGFloat { get }

    /// Large (32pt)
    var lg: CGFloat { get }

    /// Extra large (48pt) - hero
    var xl: CGFloat { get }

    /// Largest (64pt) - display
    var xxl: CGFloat { get }
}
