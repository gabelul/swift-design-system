import SwiftUI

/// ViewModifier that applies typography
struct TypographyModifier: ViewModifier {
    let token: Typography
    let design: Font.Design?

    func body(content: Content) -> some View {
        content
            .font(design.map { token.font(design: $0) } ?? token.font)
            .lineSpacing(token.lineHeight - token.size)
    }
}

public extension View {
    /// Applies a typography token
    ///
    /// ```swift
    /// Text("Headline")
    ///     .typography(.headlineLarge)
    ///
    /// Text("Headline")
    ///     .typography(.headlineLarge, design: .serif)
    /// ```
    func typography(_ token: Typography, design: Font.Design? = nil) -> some View {
        modifier(TypographyModifier(token: token, design: design))
    }
}
