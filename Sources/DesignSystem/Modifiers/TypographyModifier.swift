import SwiftUI

/// ViewModifier that applies typography
struct TypographyModifier: ViewModifier {
    @Environment(\.typographyProvider) private var typographyProvider

    let token: Typography
    let design: Font.Design?

    func body(content: Content) -> some View {
        content
            .font(typographyProvider.font(for: token, design: design))
            .lineSpacing(typographyProvider.lineSpacing(for: token))
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
