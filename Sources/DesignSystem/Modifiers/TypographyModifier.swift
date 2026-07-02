import SwiftUI

public extension View {
    /// Applies a typography token.
    ///
    /// Pass a role (``Typography``) and the size, weight, line height, and font
    /// resolved by the Environment's ``TypographyScale`` are applied. A theme can
    /// swap the scale for a brand-specific ramp; with no scale installed,
    /// ``DefaultTypographyScale`` (derived from the built-in values) keeps the
    /// original look.
    ///
    /// Resolution needs an Environment read, so it's wrapped in the lightweight
    /// ``TypographyStyledView`` rather than a `ViewModifier`. A modifier's
    /// `body(content:)` is `@MainActor`-isolated, which triggers "non-Sendable
    /// result" errors when called from a Sendable closure (PhotosPicker, etc.).
    /// Building a View is nonisolated, so it stays safe inside Sendable closures.
    ///
    /// ```swift
    /// Text("Headline").typography(.headlineLarge)
    /// Text("Headline").typography(.headlineLarge, design: .serif)
    /// ```
    func typography(_ token: Typography, design: Font.Design? = nil) -> some View {
        TypographyStyledView(role: token, design: design, content: self)
    }
}

/// Internal View that resolves `.typography(_:)`. Reads the Environment scale and applies it.
private struct TypographyStyledView<Content: View>: View {
    let role: Typography
    let design: Font.Design?
    let content: Content
    @Environment(\.typographyScale) private var scale

    var body: some View {
        let style = scale.style(for: role)
        return content
            .font(style.font(design: design))
            .lineSpacing(max(0, style.lineHeight - style.size))
            .tracking((style.trackingEm ?? 0) * style.size)
    }
}
