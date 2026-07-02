import SwiftUI

/// App-configurable typography policy, expressed as a ``TypographyScale``.
///
/// Lets apps keep semantic `Typography` tokens while swapping font families,
/// applying a global scale, and declaring a serif editorial voice — without
/// forking components or button styles. With nothing configured it resolves to
/// system fonts, identical to ``DefaultTypographyScale``.
///
/// Since upstream v1.7.0 moved resolution to `TypographyScale`/`\.typographyScale`,
/// this type conforms to `TypographyScale` and the `.typographyProvider(_:)`
/// modifier installs it there. Existing app call sites don't change.
public struct TypographyProvider: TypographyScale {
    public var sansFontName: String?
    public var serifFontName: String?
    public var monoFontName: String?
    public var scale: CGFloat

    /// Tokens that render serif by default when a call site doesn't pin a design.
    ///
    /// The app's *editorial policy*: the DesignSystem stays unopinionated (empty
    /// set = every token resolves sans), but an app can declare, once, which size
    /// roles carry its serif voice — e.g. `[.displayLarge, .displayMedium,
    /// .displaySmall]` to make the whole display tier serif app-wide. Beats
    /// hand-typing `design: .serif` on every title. An explicit `design:` at the
    /// call site always wins.
    public var serifTokens: Set<Typography>

    public init(
        sansFontName: String? = nil,
        serifFontName: String? = nil,
        monoFontName: String? = nil,
        scale: CGFloat = 1.0,
        serifTokens: Set<Typography> = []
    ) {
        self.sansFontName = sansFontName?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty
        self.serifFontName = serifFontName?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty
        self.monoFontName = monoFontName?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty
        self.scale = scale
        self.serifTokens = serifTokens
    }

    public func style(for role: Typography) -> TypeStyle {
        let isSerif = serifTokens.contains(role)
        let resource: FontResource
        let design: Font.Design?

        if isSerif {
            if let serifFontName {
                // A bundled/host serif font wins; a named font already carries its
                // own design, so no system design axis is needed.
                resource = .named(serifFontName)
                design = nil
            } else {
                // No serif font configured → system serif (New York). SF Symbols
                // ignore Font.Design, so serif on a glyph is a harmless no-op.
                resource = .system
                design = .serif
            }
        } else {
            resource = sansFontName.map(FontResource.named) ?? .system
            design = nil
        }

        return TypeStyle(
            size: role.size * scale,
            weight: role.weight,
            leadingMultiplier: role.size > 0 ? role.lineHeight / role.size : 1,
            fontResource: resource,
            design: design
        )
    }
}

public extension View {
    /// Installs an app typography policy for this subtree (as the Environment scale).
    ///
    /// ```swift
    /// ContentView()
    ///     .typographyProvider(
    ///         TypographyProvider(
    ///             serifFontName: "SourceSerif4",
    ///             serifTokens: [.displayLarge, .displayMedium, .displaySmall]
    ///         )
    ///     )
    /// ```
    func typographyProvider(_ provider: TypographyProvider) -> some View {
        environment(\.typographyScale, provider)
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
