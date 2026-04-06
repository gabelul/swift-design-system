import SwiftUI

/// Light mode palette derived from a single brand color using HSB manipulation
///
/// Primary, secondary, and tertiary colors shift hue from the brand color.
/// Surface and background colors are desaturated tints of the brand hue.
/// Semantic state colors (error, warning, success, info) stay fixed regardless of brand.
struct DynamicLightPalette: ColorPalette {
    let primary: Color
    let secondary: Color
    let tertiary: Color
    let background: Color
    let onBackground: Color
    let surface: Color
    let onSurface: Color
    let surfaceVariant: Color
    let onSurfaceVariant: Color
    let error: Color
    let warning: Color
    let success: Color
    let info: Color
    let outline: Color

    /// Derives a full light palette from a brand color
    ///
    /// - Parameter brandColor: The single color that defines the brand identity
    init(brandColor: Color) {
        // Primary family — the brand color itself
        self.primary = brandColor

        // Secondary — hue shifted +30° (≈0.083 on 0–1 scale), slightly desaturated
        self.secondary = brandColor.adjustingHSB(hueShift: 0.083, saturationMultiplier: 0.8)

        // Tertiary — hue shifted −30°, slightly desaturated
        self.tertiary = brandColor.adjustingHSB(hueShift: -0.083, saturationMultiplier: 0.9)

        // Surfaces — brand-tinted neutrals
        self.background = brandColor.asSurface(saturation: 0.02, brightness: 1.0)
        self.onBackground = Color(white: 0.1)
        self.surface = brandColor.asSurface(saturation: 0.03, brightness: 0.98)
        self.onSurface = Color(white: 0.1)
        self.surfaceVariant = brandColor.asSurface(saturation: 0.06, brightness: 0.95)
        self.onSurfaceVariant = Color(white: 0.35)

        // Semantic state colors — fixed, don't shift with brand
        self.error = Color(hex: "#DC2626")
        self.warning = Color(hex: "#F59E0B")
        self.success = Color(hex: "#10B981")
        self.info = Color(hex: "#3B82F6")

        // Outline — neutral with slight brand tint
        self.outline = brandColor.asSurface(saturation: 0.04, brightness: 0.80)
    }
}
