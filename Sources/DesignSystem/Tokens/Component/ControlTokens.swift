import Foundation

/// Control dimension and state tokens.
///
/// Fixes theme-independent universal values (e.g. derived from HIG) as vocabulary.
/// Promote to a Semantic scale once a value needs to vary per theme.
public enum ControlTokens {
    /// Minimum touch target side (HIG: 44pt).
    /// Interactive elements — circular button and input bar heights, etc. — must never fall below this.
    public static let minTouchTarget: CGFloat = 44

    /// Disabled-state opacity. The unified value for disabled controls.
    public static let disabledOpacity: Double = 0.5
}
