import SwiftUI

extension View {
    /// Applies design system theme
    ///
    /// Applies a theme to the entire View hierarchy using ThemeProvider.
    /// By applying to the app's root view, design tokens become available in all child views.
    ///
    /// - Parameter provider: ThemeProvider instance
    /// - Returns: View with theme applied
    ///
    /// ## Usage Example
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     @State private var themeProvider = ThemeProvider()
    ///
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .theme(themeProvider)  // Apply here
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// After applying theme, design tokens can be used in child views:
    /// ```swift
    /// struct ContentView: View {
    ///     @Environment(\.colorPalette) var colors
    ///     @Environment(\.spacingScale) var spacing
    ///
    ///     var body: some View {
    ///         Text("Hello")
    ///             .foregroundColor(colors.primary)
    ///             .padding(spacing.lg)
    ///     }
    /// }
    /// ```
    public func theme(_ provider: ThemeProvider) -> some View {
        modifier(ThemeModifier(provider: provider))
    }
}
