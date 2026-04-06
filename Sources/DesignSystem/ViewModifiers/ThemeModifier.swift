import SwiftUI

/// View modifier that applies a theme
public struct ThemeModifier: ViewModifier {
    @Bindable var provider: ThemeProvider

    public init(provider: ThemeProvider) {
        self.provider = provider
    }

    public func body(content: Content) -> some View {
        ThemeEnvironmentView(provider: provider, content: content)
    }
}

/// Internal view that provides theme environment values
/// Dedicated view to ensure reliable change tracking via @Bindable
private struct ThemeEnvironmentView<Content: View>: View {
    @Bindable var provider: ThemeProvider
    @Environment(\.colorScheme) private var systemColorScheme
    let content: Content

    /// Resolves the actual mode to use
    /// - `.system`: Follows the system ColorScheme
    /// - `.light`/`.dark`: Respects the user's manual selection
    private var resolvedMode: ThemeMode {
        switch provider.themeMode {
        case .system:
            return systemColorScheme == .dark ? .dark : .light
        case .light, .dark:
            return provider.themeMode
        }
    }

    /// The actual SwiftUI ColorScheme to apply
    private var resolvedColorScheme: ColorScheme {
        resolvedMode == .dark ? .dark : .light
    }

    /// The actual color palette to apply (reactive)
    /// Automatically recalculated when provider.currentTheme changes
    private var resolvedColorPalette: any ColorPalette {
        provider.currentTheme.colorPalette(for: resolvedMode)
    }

    var body: some View {
        content
            .environment(provider)
            .environment(\.colorPalette, resolvedColorPalette)
            .environment(\.spacingScale, DefaultSpacingScale())
            .environment(\.radiusScale, DefaultRadiusScale())
            .colorScheme(resolvedColorScheme)
    }
}
