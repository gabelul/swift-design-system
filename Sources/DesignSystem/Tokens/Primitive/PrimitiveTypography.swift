import Foundation

/// Primitive typography tokens
///
/// Defines base font size and line height values.
/// **Avoid direct use** — reference these through the `Typography` enum instead.
///
/// ## Usage
/// ```swift
/// // Don't use directly
/// Text("Sample").font(.system(size: PrimitiveTypography.size16))
///
/// // Preferred
/// Text("Sample").typography(.bodyMedium)
/// ```
///
/// ## Value Basis
/// - Follows Material Design 3 type scale
/// - Line heights based on 8pt grid system
public enum PrimitiveTypography {
    // MARK: - Font Sizes

    /// 11pt - Label Small equivalent
    public static let size11: CGFloat = 11

    /// 12pt - Body Small, Label Medium equivalent
    public static let size12: CGFloat = 12

    /// 14pt - Body Medium, Title Small, Label Large equivalent
    public static let size14: CGFloat = 14

    /// 16pt - Body Large, Title Medium equivalent
    public static let size16: CGFloat = 16

    /// 22pt - Title Large equivalent
    public static let size22: CGFloat = 22

    /// 24pt - Headline Small equivalent
    public static let size24: CGFloat = 24

    /// 28pt - Headline Medium equivalent
    public static let size28: CGFloat = 28

    /// 32pt - Headline Large equivalent
    public static let size32: CGFloat = 32

    /// 36pt - Display Small equivalent
    public static let size36: CGFloat = 36

    /// 45pt - Display Medium equivalent
    public static let size45: CGFloat = 45

    /// 57pt - Display Large equivalent
    public static let size57: CGFloat = 57

    // MARK: - Line Heights

    /// 16pt - Minimum line height (for Small text)
    public static let lineHeight16: CGFloat = 16

    /// 20pt - Small to Medium text line height
    public static let lineHeight20: CGFloat = 20

    /// 24pt - Body/Title line height
    public static let lineHeight24: CGFloat = 24

    /// 28pt - Title Large line height
    public static let lineHeight28: CGFloat = 28

    /// 32pt - Headline Small line height
    public static let lineHeight32: CGFloat = 32

    /// 36pt - Headline Medium line height
    public static let lineHeight36: CGFloat = 36

    /// 40pt - Headline Large line height
    public static let lineHeight40: CGFloat = 40

    /// 44pt - Display Small line height
    public static let lineHeight44: CGFloat = 44

    /// 52pt - Display Medium line height
    public static let lineHeight52: CGFloat = 52

    /// 64pt - Display Large line height
    public static let lineHeight64: CGFloat = 64
}
