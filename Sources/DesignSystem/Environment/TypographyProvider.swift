import SwiftUI

/// Environment-driven typography resolver.
///
/// Lets apps keep semantic `Typography` tokens while swapping font families
/// and applying a global scale without forking components or button styles.
/// When no custom families are configured, DesignSystem falls back to system fonts.
public struct TypographyProvider: Sendable {
    public var sansFontName: String?
    public var serifFontName: String?
    public var monoFontName: String?
    public var scale: CGFloat

    public init(
        sansFontName: String? = nil,
        serifFontName: String? = nil,
        monoFontName: String? = nil,
        scale: CGFloat = 1.0
    ) {
        self.sansFontName = sansFontName?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty
        self.serifFontName = serifFontName?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty
        self.monoFontName = monoFontName?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty
        self.scale = scale
    }

    func font(for token: Typography, design: Font.Design?) -> Font {
        let resolvedDesign = design ?? .default
        let size = pointSize(for: token)

        guard let name = fontName(for: resolvedDesign) else {
            return .system(size: size, weight: token.weight, design: resolvedDesign)
        }

        return Font
            .custom(name, size: size, relativeTo: textStyle(for: token))
            .weight(token.weight)
    }

    func pointSize(for token: Typography) -> CGFloat {
        token.size * scale
    }

    func lineSpacing(for token: Typography) -> CGFloat {
        (token.lineHeight - token.size) * scale
    }

    func fontName(for design: Font.Design) -> String? {
        switch design {
        case .serif:
            return serifFontName ?? sansFontName
        case .monospaced:
            return monoFontName ?? sansFontName
        case .rounded:
            return sansFontName
        case .default:
            return sansFontName
        @unknown default:
            return sansFontName
        }
    }

    private func textStyle(for token: Typography) -> Font.TextStyle {
        switch token {
        case .displayLarge: return .largeTitle
        case .displayMedium: return .largeTitle
        case .displaySmall: return .title
        case .headlineLarge: return .title
        case .headlineMedium: return .title2
        case .headlineSmall: return .title3
        case .titleLarge: return .headline
        case .titleMedium: return .headline
        case .titleSmall: return .subheadline
        case .bodyLarge: return .body
        case .bodyMedium: return .callout
        case .bodySmall: return .footnote
        case .labelLarge: return .callout
        case .labelMedium: return .footnote
        case .labelSmall: return .caption
        }
    }
}

private struct TypographyProviderKey: EnvironmentKey {
    static let defaultValue = TypographyProvider()
}

public extension EnvironmentValues {
    var typographyProvider: TypographyProvider {
        get { self[TypographyProviderKey.self] }
        set { self[TypographyProviderKey.self] = newValue }
    }
}

public extension View {
    /// Installs a typography provider for this subtree.
    ///
    /// Example:
    /// ```swift
    /// ContentView()
    ///     .typographyProvider(
    ///         TypographyProvider(
    ///             sansFontName: "Inter",
    ///             serifFontName: "SourceSerif4",
    ///             scale: 1.0
    ///         )
    ///     )
    /// ```
    func typographyProvider(_ provider: TypographyProvider) -> some View {
        environment(\.typographyProvider, provider)
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
