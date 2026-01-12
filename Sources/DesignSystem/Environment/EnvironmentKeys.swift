import SwiftUI

// MARK: - ColorPalette

private struct ColorPaletteKey: EnvironmentKey {
    static let defaultValue: any ColorPalette = LightColorPalette()
}

extension EnvironmentValues {
    public var colorPalette: any ColorPalette {
        get { self[ColorPaletteKey.self] }
        set { self[ColorPaletteKey.self] = newValue }
    }
}

// MARK: - SpacingScale

private struct SpacingScaleKey: EnvironmentKey {
    static let defaultValue: any SpacingScale = DefaultSpacingScale()
}

extension EnvironmentValues {
    public var spacingScale: any SpacingScale {
        get { self[SpacingScaleKey.self] }
        set { self[SpacingScaleKey.self] = newValue }
    }
}

// MARK: - RadiusScale

private struct RadiusScaleKey: EnvironmentKey {
    static let defaultValue: any RadiusScale = DefaultRadiusScale()
}

extension EnvironmentValues {
    public var radiusScale: any RadiusScale {
        get { self[RadiusScaleKey.self] }
        set { self[RadiusScaleKey.self] = newValue }
    }
}

// MARK: - Motion

private struct MotionKey: EnvironmentKey {
    static let defaultValue: any Motion = DefaultMotion()
}

extension EnvironmentValues {
    /// Motion timing settings
    ///
    /// Provides consistent animation timing.
    /// Use with `.animate()` modifier.
    ///
    /// ## Usage Examples
    /// ```swift
    /// @Environment(\.motion) var motion
    ///
    /// Button("Tap") { }
    ///     .scaleEffect(isPressed ? 0.98 : 1.0)
    ///     .animate(motion.tap, value: isPressed)
    /// ```
    public var motion: any Motion {
        get { self[MotionKey.self] }
        set { self[MotionKey.self] = newValue }
    }
}
