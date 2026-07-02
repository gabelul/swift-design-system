import SwiftUI

/// Preferred page density for app-owned screens.
///
/// Use this to steer the default `Screen` rhythm for a branded app without
/// inventing a second spacing system.
public enum ScreenDensity: String, CaseIterable, Sendable {
    /// Tighter rhythm for dashboards, feeds, and comparison-heavy screens.
    case compact

    /// Balanced rhythm for most app screens.
    case standard

    /// More generous rhythm for onboarding, hero, and editorial screens.
    case spacious
}

private struct ScreenDensityKey: EnvironmentKey {
    static let defaultValue: ScreenDensity = .standard
}

public extension EnvironmentValues {
    var screenDensity: ScreenDensity {
        get { self[ScreenDensityKey.self] }
        set { self[ScreenDensityKey.self] = newValue }
    }
}

public extension View {
    /// Installs a preferred page density for descendant `Screen` views.
    func screenDensity(_ density: ScreenDensity) -> some View {
        environment(\.screenDensity, density)
    }
}

/// Thin brand setup recipe for app roots.
///
/// `BrandRecipe` keeps the current DesignSystem architecture intact while
/// giving app generators one small place to define brand color/theme,
/// typography families, global scale, and preferred page density.
public struct BrandRecipe: Sendable {
    public let initialTheme: any Theme
    public let initialMode: ThemeMode
    public let additionalThemes: [any Theme]
    public let typographyProvider: TypographyProvider
    public let screenDensity: ScreenDensity

    public init(
        initialTheme: any Theme = DefaultTheme(),
        initialMode: ThemeMode = .system,
        additionalThemes: [any Theme] = [],
        typographyProvider: TypographyProvider = TypographyProvider(),
        screenDensity: ScreenDensity = .standard
    ) {
        self.initialTheme = initialTheme
        self.initialMode = initialMode
        self.additionalThemes = additionalThemes
        self.typographyProvider = typographyProvider
        self.screenDensity = screenDensity
    }

    /// Fastest path to a branded app: one color plus optional typography.
    public static func dynamic(
        brandColor: Color,
        initialMode: ThemeMode = .system,
        additionalThemes: [any Theme] = [],
        sansFontName: String? = nil,
        serifFontName: String? = nil,
        monoFontName: String? = nil,
        typographyScale: CGFloat = 1.0,
        serifTokens: Set<Typography> = [],
        screenDensity: ScreenDensity = .standard,
        themeName: String = "Dynamic",
        themeID: String = "dynamic"
    ) -> Self {
        Self(
            initialTheme: DynamicTheme(brandColor: brandColor, name: themeName, id: themeID),
            initialMode: initialMode,
            additionalThemes: additionalThemes,
            typographyProvider: TypographyProvider(
                sansFontName: sansFontName,
                serifFontName: serifFontName,
                monoFontName: monoFontName,
                scale: typographyScale,
                serifTokens: serifTokens
            ),
            screenDensity: screenDensity
        )
    }

    /// Builds a `ThemeProvider` from the recipe.
    @MainActor
    public func makeThemeProvider() -> ThemeProvider {
        ThemeProvider(
            initialTheme: initialTheme,
            initialMode: initialMode,
            additionalThemes: additionalThemes
        )
    }
}

public extension View {
    /// Installs the non-color parts of a brand recipe.
    ///
    /// Use together with `.theme(recipe.makeThemeProvider())` at app root.
    func brandRecipe(_ recipe: BrandRecipe) -> some View {
        self
            .typographyProvider(recipe.typographyProvider)
            .screenDensity(recipe.screenDensity)
    }

    /// Installs the full brand recipe in one modifier chain.
    @MainActor
    func installBrandRecipe(
        _ recipe: BrandRecipe,
        using themeProvider: ThemeProvider
    ) -> some View {
        self
            .theme(themeProvider)
            .brandRecipe(recipe)
    }
}
