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

// MARK: - TypographyScale

private struct TypographyScaleKey: EnvironmentKey {
    static let defaultValue: any TypographyScale = DefaultTypographyScale()
}

extension EnvironmentValues {
    /// Type ramp (role → style mapping).
    ///
    /// Referenced internally by the `.typography(.bodyMedium)` modifier. Supplied by the theme;
    /// when not applied, ``DefaultTypographyScale`` (derived from the existing enum) is used, so appearance is unchanged.
    public var typographyScale: any TypographyScale {
        get { self[TypographyScaleKey.self] }
        set { self[TypographyScaleKey.self] = newValue }
    }
}

// MARK: - BorderScale

private struct BorderScaleKey: EnvironmentKey {
    static let defaultValue: any BorderScale = DefaultBorderScale()
}

extension EnvironmentValues {
    /// Border width scale. Referenced via `@Environment(\.borderScale)`.
    public var borderScale: any BorderScale {
        get { self[BorderScaleKey.self] }
        set { self[BorderScaleKey.self] = newValue }
    }
}

// MARK: - StateLayer

private struct StateLayerKey: EnvironmentKey {
    static let defaultValue: any StateLayer = DefaultStateLayer()
}

extension EnvironmentValues {
    /// State layer opacity. Overlay intensity for hover/pressed/focus, etc.
    public var stateLayer: any StateLayer {
        get { self[StateLayerKey.self] }
        set { self[StateLayerKey.self] = newValue }
    }
}

// MARK: - GradientTokens

private struct GradientTokensKey: EnvironmentKey {
    static let defaultValue: any GradientTokens = DefaultGradientTokens()
}

extension EnvironmentValues {
    /// Semantic gradients. Referenced via `@Environment(\.gradients)`.
    public var gradients: any GradientTokens {
        get { self[GradientTokensKey.self] }
        set { self[GradientTokensKey.self] = newValue }
    }
}

// MARK: - ElevationScale

private struct ElevationScaleKey: EnvironmentKey {
    static let defaultValue: any ElevationScale = DefaultElevationScale()
}

extension EnvironmentValues {
    /// Shadow ramp. Referenced internally by `.elevation(.levelN)`. Themes can override shadow weight.
    public var elevationScale: any ElevationScale {
        get { self[ElevationScaleKey.self] }
        set { self[ElevationScaleKey.self] = newValue }
    }
}

// MARK: - IconSizeScale

private struct IconSizeScaleKey: EnvironmentKey {
    static let defaultValue: any IconSizeScale = DefaultIconSizeScale()
}

extension EnvironmentValues {
    /// Icon size scale.
    ///
    /// Tokenizes the display size of Image / Text emoji.
    /// Referenced internally by the `.iconSize(.sm/.md/.lg/...)` modifier.
    public var iconSizeScale: any IconSizeScale {
        get { self[IconSizeScaleKey.self] }
        set { self[IconSizeScaleKey.self] = newValue }
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
