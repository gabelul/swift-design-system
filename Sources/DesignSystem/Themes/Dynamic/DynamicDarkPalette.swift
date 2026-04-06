import SwiftUI

/// Dark mode palette derived from a single brand color using HSB manipulation
///
/// Same hue derivation as the light palette, but brightness values are inverted
/// for dark backgrounds. Surfaces use dark brand-tinted neutrals.
struct DynamicDarkPalette: ColorPalette {
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

    /// Derives a full dark palette from a brand color
    ///
    /// - Parameter brandColor: The single color that defines the brand identity
    init(brandColor: Color) {
        // Primary — slightly brighter in dark mode for visibility
        self.primary = brandColor.adjustingHSB(brightnessMultiplier: 1.1)

        // Secondary — same hue shift, boosted brightness
        self.secondary = brandColor.adjustingHSB(
            hueShift: 0.083, saturationMultiplier: 0.7, brightnessMultiplier: 1.1
        )

        // Tertiary — same hue shift, boosted brightness
        self.tertiary = brandColor.adjustingHSB(
            hueShift: -0.083, saturationMultiplier: 0.8, brightnessMultiplier: 1.1
        )

        // Dark surfaces — brand-tinted dark neutrals
        self.background = brandColor.asDarkSurface(saturation: 0.05, brightness: 0.08)
        self.onBackground = Color(white: 0.93)
        self.surface = brandColor.asDarkSurface(saturation: 0.06, brightness: 0.12)
        self.onSurface = Color(white: 0.93)
        self.surfaceVariant = brandColor.asDarkSurface(saturation: 0.08, brightness: 0.18)
        self.onSurfaceVariant = Color(white: 0.65)

        // Semantic state colors — lighter variants for dark backgrounds
        self.error = Color(hex: "#F87171")
        self.warning = Color(hex: "#FBBF24")
        self.success = Color(hex: "#34D399")
        self.info = Color(hex: "#60A5FA")

        // Outline
        self.outline = brandColor.asDarkSurface(saturation: 0.06, brightness: 0.30)
    }
}
