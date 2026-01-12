import Foundation

/// Theme color scheme
///
/// Defines the types of themes available in the application.
///
/// ## Usage Example
/// ```swift
/// @State private var selectedScheme: ThemeColorScheme = .light
///
/// Picker("Theme", selection: $selectedScheme) {
///     ForEach(ThemeColorScheme.allCases) { scheme in
///         Text(scheme.rawValue.capitalized).tag(scheme)
///     }
/// }
/// ```
public enum ThemeColorScheme: String, CaseIterable, Identifiable {
    /// Light theme
    case light

    /// Dark theme
    case dark

    public var id: String { rawValue }
}
