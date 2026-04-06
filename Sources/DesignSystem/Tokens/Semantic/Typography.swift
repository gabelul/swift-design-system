import SwiftUI

/// Typography tokens.
///
/// Predefined font scales that provide consistent text styling.
/// Font size, weight, and line height are optimized and easily applied with the `.typography()` modifier.
///
/// ## Example
/// ```swift
/// Text("Large Headline")
///     .typography(.headlineLarge)
///
/// Text("Body text")
///     .typography(.bodyMedium)
///
/// Button("Button label") { }
///     .typography(.labelLarge)
/// ```
///
/// ## Categories
/// - **Display**: largest sizes (57–36pt) – hero sections, landing pages
/// - **Headline**: headings (32–24pt) – section headers
/// - **Title**: titles (22–14pt) – card titles, dialogs
/// - **Body**: body text (16–12pt) – paragraphs, descriptions
/// - **Label**: labels (14–11pt) – buttons, tabs, form labels
public enum Typography {
    // MARK: - Display

    /// Display Large – largest and most prominent text.
    /// Size: 57pt, Weight: Bold
    case displayLarge

    /// Display Medium.
    /// Size: 45pt, Weight: Bold
    case displayMedium

    /// Display Small.
    /// Size: 36pt, Weight: Bold
    case displaySmall

    // MARK: - Headline

    /// Headline Large – large section heading.
    /// Size: 32pt, Weight: Semibold
    case headlineLarge

    /// Headline Medium – medium section heading.
    /// Size: 28pt, Weight: Semibold
    case headlineMedium

    /// Headline Small – smaller section heading.
    /// Size: 24pt, Weight: Semibold
    case headlineSmall

    // MARK: - Title

    /// Title Large – large title text.
    /// Size: 22pt, Weight: Semibold
    case titleLarge

    /// Title Medium – medium title text.
    /// Size: 16pt, Weight: Semibold
    case titleMedium

    /// Title Small – small title text.
    /// Size: 14pt, Weight: Semibold
    case titleSmall

    // MARK: - Body

    /// Body Large – large body text.
    /// Size: 16pt, Weight: Regular
    case bodyLarge

    /// Body Medium – standard body text.
    /// Size: 14pt, Weight: Regular
    case bodyMedium

    /// Body Small – small body text.
    /// Size: 12pt, Weight: Regular
    case bodySmall

    // MARK: - Label

    /// Label Large – larger labels (buttons, tabs, etc.).
    /// Size: 14pt, Weight: Medium
    case labelLarge

    /// Label Medium – standard labels.
    /// Size: 12pt, Weight: Medium
    case labelMedium

    /// Label Small – small labels.
    /// Size: 11pt, Weight: Medium
    case labelSmall

    // MARK: - Properties

    /// Font size (pt).
    public var size: CGFloat {
        switch self {
        // Display
        case .displayLarge: return PrimitiveTypography.size57
        case .displayMedium: return PrimitiveTypography.size45
        case .displaySmall: return PrimitiveTypography.size36

        // Headline
        case .headlineLarge: return PrimitiveTypography.size32
        case .headlineMedium: return PrimitiveTypography.size28
        case .headlineSmall: return PrimitiveTypography.size24

        // Title
        case .titleLarge: return PrimitiveTypography.size22
        case .titleMedium: return PrimitiveTypography.size16
        case .titleSmall: return PrimitiveTypography.size14

        // Body
        case .bodyLarge: return PrimitiveTypography.size16
        case .bodyMedium: return PrimitiveTypography.size14
        case .bodySmall: return PrimitiveTypography.size12

        // Label
        case .labelLarge: return PrimitiveTypography.size14
        case .labelMedium: return PrimitiveTypography.size12
        case .labelSmall: return PrimitiveTypography.size11
        }
    }

    /// Font weight.
    public var weight: Font.Weight {
        switch self {
        // Display
        case .displayLarge, .displayMedium, .displaySmall:
            return .bold

        // Headline
        case .headlineLarge, .headlineMedium, .headlineSmall:
            return .semibold

        // Title
        case .titleLarge, .titleMedium, .titleSmall:
            return .semibold

        // Body
        case .bodyLarge, .bodyMedium, .bodySmall:
            return .regular

        // Label
        case .labelLarge, .labelMedium, .labelSmall:
            return .medium
        }
    }

    /// SwiftUI `Font`, compatible with Dynamic Type.
    public var font: Font {
        .system(size: size, weight: weight, design: .default)
    }

    /// SwiftUI `Font` with a custom design.
    /// - Parameter design: Font design (.default, .serif, .rounded, .monospaced).
    /// - Returns: Font with the specified design.
    public func font(design: Font.Design) -> Font {
        .system(size: size, weight: weight, design: design)
    }

    /// Line height, based on the Material Design 3 spec.
    public var lineHeight: CGFloat {
        switch self {
        // Display
        case .displayLarge: return PrimitiveTypography.lineHeight64
        case .displayMedium: return PrimitiveTypography.lineHeight52
        case .displaySmall: return PrimitiveTypography.lineHeight44

        // Headline
        case .headlineLarge: return PrimitiveTypography.lineHeight40
        case .headlineMedium: return PrimitiveTypography.lineHeight36
        case .headlineSmall: return PrimitiveTypography.lineHeight32

        // Title
        case .titleLarge: return PrimitiveTypography.lineHeight28
        case .titleMedium: return PrimitiveTypography.lineHeight24
        case .titleSmall: return PrimitiveTypography.lineHeight20

        // Body
        case .bodyLarge: return PrimitiveTypography.lineHeight24
        case .bodyMedium: return PrimitiveTypography.lineHeight20
        case .bodySmall: return PrimitiveTypography.lineHeight16

        // Label
        case .labelLarge: return PrimitiveTypography.lineHeight20
        case .labelMedium: return PrimitiveTypography.lineHeight16
        case .labelSmall: return PrimitiveTypography.lineHeight16
        }
    }
}
