import SwiftUI

/// Protocol that defines a design system theme
///
/// A theme provides metadata such as name, description, and category,
/// as well as color palettes for light and dark modes.
///
/// ## Usage Example
/// ```swift
/// struct CustomTheme: Theme {
///     var id: String { "custom" }
///     var name: String { "Custom" }
///     var description: String { "Custom color theme" }
///     var category: ThemeCategory { .brandPersonality }
///     var previewColors: [Color] { [.blue, .cyan, .teal] }
///
///     func colorPalette(for mode: ThemeMode) -> any ColorPalette {
///         switch mode {
///         case .system, .light:
///             CustomLightPalette()
///         case .dark:
///             CustomDarkPalette()
///         }
///     }
/// }
/// ```
public protocol Theme: Sendable, Identifiable, Equatable {
    /// Unique identifier for the theme
    var id: String { get }

    /// Display name of the theme
    var name: String { get }

    /// Description of the theme
    var description: String { get }

    /// Category of the theme
    var category: ThemeCategory { get }

    /// Representative colors for preview (3-5 colors)
    var previewColors: [Color] { get }

    /// Returns the color palette corresponding to the specified mode
    /// - Parameter mode: Light mode or dark mode
    /// - Returns: Corresponding color palette
    func colorPalette(for mode: ThemeMode) -> any ColorPalette

    /// The theme's icon size scale.
    ///
    /// A token referenced by `Image(systemName:).iconSize(.sm/.md/...)` and similar modifiers.
    /// The default implementation returns ``DefaultIconSizeScale``, so themes that don't
    /// need special customization don't need to override this.
    var iconSizeScale: any IconSizeScale { get }

    /// The theme's motion timing.
    ///
    /// A token referenced by `.animate(motion.tap, value:)` and similar modifiers.
    /// The default implementation returns ``DefaultMotion``, so themes that don't
    /// need special customization don't need to override this.
    var motion: any Motion { get }

    /// The theme's type ramp (typography scale).
    ///
    /// Supplies the token referenced by `.typography(.bodyMedium)` and similar modifiers.
    /// The default implementation returns ``DefaultTypographyScale`` (derived from the existing
    /// values), so themes that don't customize type don't need to override this and appearance
    /// stays the same. Brand themes override this to inject their own type (size, line height, typeface).
    var typographyScale: any TypographyScale { get }

    /// The theme's spacing scale.
    ///
    /// A token referenced by components via `@Environment(\.spacingScale)`.
    /// The default implementation returns ``DefaultSpacingScale``, so appearance stays
    /// unchanged without an override. Brand themes override this to inject their own
    /// spacing (e.g. SmartHR's char-relative spacing).
    var spacingScale: any SpacingScale { get }

    /// The theme's corner radius scale.
    ///
    /// A token referenced by components via `@Environment(\.radiusScale)`.
    /// The default implementation returns ``DefaultRadiusScale``, so appearance stays
    /// unchanged without an override.
    var radiusScale: any RadiusScale { get }

    /// Border width scale. Defaults to ``DefaultBorderScale``.
    var borderScale: any BorderScale { get }

    /// State layer opacity. Defaults to ``DefaultStateLayer``.
    var stateLayer: any StateLayer { get }

    /// Semantic gradients. Defaults to ``DefaultGradientTokens``. Brands inject their own.
    var gradients: any GradientTokens { get }

    /// Shadow ramp. Defaults to ``DefaultElevationScale`` (derived from the existing enum).
    var elevationScale: any ElevationScale { get }
}

// MARK: - Equatable Default Implementation

public extension Theme {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Default Token Implementations

public extension Theme {
    var iconSizeScale: any IconSizeScale {
        DefaultIconSizeScale()
    }

    var motion: any Motion {
        DefaultMotion()
    }

    var typographyScale: any TypographyScale {
        DefaultTypographyScale()
    }

    var spacingScale: any SpacingScale {
        DefaultSpacingScale()
    }

    var radiusScale: any RadiusScale {
        DefaultRadiusScale()
    }

    var borderScale: any BorderScale {
        DefaultBorderScale()
    }

    var stateLayer: any StateLayer {
        DefaultStateLayer()
    }

    var gradients: any GradientTokens {
        DefaultGradientTokens()
    }

    var elevationScale: any ElevationScale {
        DefaultElevationScale()
    }
}
