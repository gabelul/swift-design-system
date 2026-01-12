import SwiftUI

public extension Color {
    /// Creates a Color from a HEX string
    ///
    /// Allows defining custom brand colors or designer-provided colors in HEX format.
    /// Supports HEX formats with or without `#`, in 3/6/8 digit formats.
    ///
    /// - Parameter hex: HEX string (examples: `"#FF5733"`, `"FF5733"`, `"#F57"`, `"AAFF5733"`)
    ///
    /// ## Usage Examples
    /// ```swift
    /// // 6-digit HEX (most common)
    /// let brandColor = Color(hex: "#FF5733")
    ///
    /// // Also works without #
    /// let accentColor = Color(hex: "3B82F6")
    ///
    /// // 3-digit shorthand format
    /// let redColor = Color(hex: "#F00")  // Same as #FF0000
    ///
    /// // 8-digit HEX (with alpha channel)
    /// let semiTransparent = Color(hex: "80FF5733")  // 50% opacity
    /// ```
    ///
    /// ## Usage in Custom Palettes
    /// ```swift
    /// struct MyBrandPalette: ColorPalette {
    ///     var primary: Color { Color(hex: "#007AFF") }
    ///     var secondary: Color { Color(hex: "#5856D6") }
    ///     var background: Color { .white }
    ///     // ...
    /// }
    /// ```
    ///
    /// ## Formats
    /// - **3 digits**: RGB (4-bit per channel) - example: `"F00"` → `"FF0000"`
    /// - **6 digits**: RGB (8-bit per channel) - example: `"FF5733"`
    /// - **8 digits**: ARGB (alpha + RGB) - example: `"80FF5733"`
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
