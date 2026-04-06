import Foundation

/// Spacing scale protocol
///
/// A scale system for providing consistent margins and spacing.
/// Uses t-shirt size naming (xs, sm, md, lg, xl...) for intuitive use.
///
/// ## Usage
/// ```swift
/// @Environment(\.spacingScale) var spacing
///
/// VStack(spacing: spacing.lg) {  // 16pt spacing
///     Text("Title")
///     Text("Subtitle")
/// }
/// .padding(spacing.xl)  // 24pt padding
/// ```
///
/// ## Scale Reference
/// - `none`: 0pt - No spacing
/// - `xxs`: 2pt - Smallest spacing
/// - `xs`: 4pt - Very small spacing
/// - `sm`: 8pt - Small spacing
/// - `md`: 12pt - Medium spacing
/// - `lg`: 16pt - Standard spacing (recommended default)
/// - `xl`: 24pt - Large spacing
/// - `xxl`: 32pt - Very large spacing
/// - `xxxl`: 48pt - Extra large spacing
/// - `xxxxl`: 64pt - Maximum spacing
public protocol SpacingScale: Sendable {
    /// No spacing (0pt)
    var none: CGFloat { get }

    /// Smallest spacing (2pt)
    var xxs: CGFloat { get }

    /// Very small spacing (4pt)
    var xs: CGFloat { get }

    /// Small spacing (8pt)
    var sm: CGFloat { get }

    /// Medium spacing (12pt)
    var md: CGFloat { get }

    /// Standard spacing (16pt) - recommended default
    var lg: CGFloat { get }

    /// Large spacing (24pt)
    var xl: CGFloat { get }

    /// Very large spacing (32pt)
    var xxl: CGFloat { get }

    /// Extra large spacing (48pt)
    var xxxl: CGFloat { get }

    /// Maximum spacing (64pt)
    var xxxxl: CGFloat { get }
}
