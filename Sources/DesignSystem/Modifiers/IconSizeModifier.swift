import SwiftUI

public extension View {
    /// Sets the size of an icon (Image / Text emoji) using a token.
    ///
    /// A responsibility separate from `Typography`: an icon is the size of a
    /// visual element, with its own scale independent of the text's
    /// line-height / letter-spacing. Applies to either `SF Symbol` or
    /// `Emoji`.
    ///
    /// Implemented by chaining SwiftUI's standard modifier directly rather
    /// than going through a `ViewModifier`, so it can still apply to an
    /// Image inside a Sendable closure (e.g. PhotosPicker) under Swift 6
    /// strict concurrency (same reasoning as `typography()`).
    ///
    /// ```swift
    /// Image(systemName: "checkmark")
    ///     .iconSize(.sm)      // 16pt, aligned with body text
    ///
    /// Text(emoji).iconSize(.lg)   // 32pt, category display
    /// ```
    func iconSize(_ size: IconSizeToken) -> some View {
        // Inlines resolveSize to keep this a pure computation
        // (deliberately mirrors the shape of typography() to avoid
        // inheriting @MainActor).
        let scale = DefaultIconSizeScale()
        let pt: CGFloat
        switch size {
        case .xxs: pt = scale.xxs
        case .xs: pt = scale.xs
        case .sm: pt = scale.sm
        case .md: pt = scale.md
        case .lg: pt = scale.lg
        case .xl: pt = scale.xl
        case .xxl: pt = scale.xxl
        }
        return self.font(.system(size: pt))
    }
}

/// Token values specified via `.iconSize(.xs/.sm/.md/.lg/.xl/.xxl)`.
public enum IconSizeToken: Sendable {
    case xxs, xs, sm, md, lg, xl, xxl
}
