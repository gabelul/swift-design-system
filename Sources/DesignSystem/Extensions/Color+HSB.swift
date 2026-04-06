import SwiftUI

public extension Color {
    /// Extracts HSB (hue, saturation, brightness, alpha) components from a Color
    ///
    /// Uses platform-specific APIs to resolve the color into HSB space.
    /// Works with both UIKit (iOS) and AppKit (macOS) color representations.
    ///
    /// ## Usage
    /// ```swift
    /// let brand = Color(hex: "#6366F1")
    /// let (h, s, b, a) = brand.hsbComponents()
    /// // h ≈ 0.66, s ≈ 0.58, b ≈ 0.95
    /// ```
    func hsbComponents() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        #if canImport(UIKit)
        let uiColor = UIColor(self)
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        #elseif canImport(AppKit)
        let nsColor = NSColor(self).usingColorSpace(.sRGB) ?? NSColor(self)
        nsColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        #endif

        return (hue, saturation, brightness, alpha)
    }

    /// Creates a new Color by shifting HSB components
    ///
    /// - Parameters:
    ///   - hueShift: Amount to rotate hue (0–1 scale, wraps around). E.g. 0.083 ≈ 30°
    ///   - saturationMultiplier: Multiply saturation by this factor (clamped to 0–1)
    ///   - brightnessMultiplier: Multiply brightness by this factor (clamped to 0–1)
    /// - Returns: A new Color with adjusted HSB values
    ///
    /// ## Usage
    /// ```swift
    /// let brand = Color(hex: "#6366F1")
    /// let secondary = brand.adjustingHSB(hueShift: 0.083, saturationMultiplier: 0.8)
    /// ```
    func adjustingHSB(
        hueShift: CGFloat = 0,
        saturationMultiplier: CGFloat = 1,
        brightnessMultiplier: CGFloat = 1
    ) -> Color {
        let (h, s, b, a) = hsbComponents()
        let newHue = (h + hueShift).truncatingRemainder(dividingBy: 1.0)
        let newSaturation = min(max(s * saturationMultiplier, 0), 1)
        let newBrightness = min(max(b * brightnessMultiplier, 0), 1)

        return Color(
            hue: newHue < 0 ? newHue + 1 : newHue,
            saturation: newSaturation,
            brightness: newBrightness,
            opacity: a
        )
    }

    /// Creates a desaturated, lighter variant suitable for surface/background use
    ///
    /// - Parameters:
    ///   - saturation: Target saturation (0–1). Lower = more neutral.
    ///   - brightness: Target brightness (0–1). Higher = lighter.
    /// - Returns: A tinted neutral derived from the original hue
    func asSurface(saturation: CGFloat = 0.05, brightness: CGFloat = 0.98) -> Color {
        let (h, _, _, a) = hsbComponents()
        return Color(hue: h, saturation: saturation, brightness: brightness, opacity: a)
    }

    /// Creates a desaturated, darker variant suitable for dark mode surfaces
    ///
    /// - Parameters:
    ///   - saturation: Target saturation (0–1)
    ///   - brightness: Target brightness (0–1). Lower = darker.
    /// - Returns: A tinted dark neutral derived from the original hue
    func asDarkSurface(saturation: CGFloat = 0.08, brightness: CGFloat = 0.12) -> Color {
        let (h, _, _, a) = hsbComponents()
        return Color(hue: h, saturation: saturation, brightness: brightness, opacity: a)
    }
}
