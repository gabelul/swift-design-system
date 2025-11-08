import SwiftUI

/// タイポグラフィを適用するViewModifier
struct TypographyModifier: ViewModifier {
    let token: Typography

    func body(content: Content) -> some View {
        content
            .font(token.font)
            .lineSpacing(token.lineHeight - token.size)
    }
}

public extension View {
    /// タイポグラフィトークンを適用
    ///
    /// ```swift
    /// Text("見出し")
    ///     .typography(.headlineLarge)
    /// ```
    func typography(_ token: Typography) -> some View {
        modifier(TypographyModifier(token: token))
    }
}
