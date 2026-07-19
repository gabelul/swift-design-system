import SwiftUI

/// HighContrast theme - dark mode palette (WCAG AAA compliant)
struct HighContrastDarkPalette: ColorPalette {
    // MARK: - Primary
    var primary: Color { Color(hex: "#82B1FF") } // Bright blue for dark mode high contrast
    var onPrimary: Color { Color(hex: "#00174A") }
    var primaryContainer: Color { Color(hex: "#003D99") }
    var onPrimaryContainer: Color { Color(hex: "#D4E5FF") }

    // MARK: - Secondary
    var secondary: Color { Color(hex: "#E891FF") } // Bright purple for dark mode high contrast
    var onSecondary: Color { Color(hex: "#3D004D") }
    var secondaryContainer: Color { Color(hex: "#6B0080") }
    var onSecondaryContainer: Color { Color(hex: "#F9D5FF") }

    // MARK: - Tertiary
    var tertiary: Color { Color(hex: "#4DFF9F") } // Bright teal for dark mode high contrast
    var onTertiary: Color { Color(hex: "#003828") }

    // MARK: - Background & Surface
    var background: Color { .black }
    var onBackground: Color { .white }
    var surface: Color { Color(hex: "#121212") } // Slightly elevated black
    var onSurface: Color { .white }
    var surfaceVariant: Color { Color(hex: "#1E1E1E") }
    var onSurfaceVariant: Color { Color(hex: "#E0E0E0") }

    // MARK: - Semantic State
    // Dark text on bright fills. The default on-colors are .white, so without these
    // overrides you get white text on a bright fill — unreadable.
    // error can't stay #FF5252: its relative luminance of 0.279 caps the ratio at 6.58
    // even with pure black text, so AAA (7.0) is unreachable. The fill itself is brightened instead.
    var error: Color { Color(hex: "#FF8A80") } // Bright red for high contrast
    var onError: Color { Color(hex: "#2D0000") }
    var warning: Color { Color(hex: "#FFD54F") } // Bright yellow for high contrast
    var success: Color { Color(hex: "#69F0AE") } // Bright green for high contrast
    var onSuccess: Color { Color(hex: "#003828") }
    var info: Color { Color(hex: "#82B1FF") } // Matches primary
    var onInfo: Color { Color(hex: "#00174A") } // Matches onPrimary since info matches primary

    // MARK: - Outline
    var outline: Color { Color(hex: "#E0E0E0") } // High contrast outline for dark mode
    var outlineVariant: Color { Color(hex: "#BDBDBD") }
}
