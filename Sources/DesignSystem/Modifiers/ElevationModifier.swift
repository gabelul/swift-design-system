import SwiftUI

/// Elevationを適用するViewModifier
struct ElevationModifier: ViewModifier {
    let level: Elevation
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content.shadow(
            color: Color.black.opacity(level.opacity(for: colorScheme)),
            radius: level.radius,
            x: level.offset.width,
            y: level.offset.height
        )
    }
}

public extension View {
    /// Elevationレベルを適用
    ///
    /// ```swift
    /// RoundedRectangle(cornerRadius: 8)
    ///     .fill(.white)
    ///     .elevation(.level2)
    /// ```
    func elevation(_ level: Elevation) -> some View {
        modifier(ElevationModifier(level: level))
    }
}
