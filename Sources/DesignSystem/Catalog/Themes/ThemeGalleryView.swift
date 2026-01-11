import SwiftUI

/// Theme gallery view
///
/// Shows all themes by category and allows selection and switching.
public struct ThemeGalleryView: View {
    @Environment(ThemeProvider.self) private var themeProvider
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // Header
                VStack(alignment: .leading, spacing: spacing.sm) {
                    HStack(spacing: spacing.sm) {
                        Image(systemName: "paintpalette.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(colors.primary)

                        Spacer()
                    }
                    .padding(.horizontal, spacing.lg)

                    Text("Theme Gallery")
                        .typography(.headlineLarge)
                        .foregroundStyle(colors.onBackground)
                        .padding(.horizontal, spacing.lg)

                    Text("Choose a theme and customize the look of your design system.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colors.onSurfaceVariant)
                        .padding(.horizontal, spacing.lg)
                }
                .padding(.top, spacing.lg)

                // Appearance mode settings
                AppearanceModeSection()

                // Theme list by category
                ForEach(ThemeCategory.allCases) { category in
                    let categoryThemes = themeProvider.availableThemes.filter { $0.category == category }
                    if !categoryThemes.isEmpty {
                        ThemeCategorySection(
                            category: category,
                            themes: categoryThemes
                        )
                    }
                }

                // Info section
                InfoSection()
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colors.background)
        .navigationTitle("Themes")
        #if os(iOS)
            .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

// MARK: - Theme Category Section

private struct ThemeCategorySection: View {
    @Environment(ThemeProvider.self) private var themeProvider
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.motion) private var motion

    let category: ThemeCategory
    let themes: [any Theme]

    var body: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            // Category header
            HStack(spacing: spacing.sm) {
                Image(systemName: category.icon)
                    .font(.title3)
                    .foregroundStyle(colors.primary)

                VStack(alignment: .leading, spacing: spacing.xxs) {
                    Text(category.rawValue)
                        .typography(.titleMedium)
                        .foregroundStyle(colors.onSurface)

                    Text(category.description)
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurfaceVariant)
                }
            }
            .padding(.horizontal, spacing.lg)

            // Theme card grid
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: spacing.md),
                    GridItem(.flexible(), spacing: spacing.md),
                ],
                spacing: spacing.md
            ) {
                ForEach(themes, id: \.id) { theme in
                    NavigationLink {
                        ThemeDetailView(theme: theme)
                            .environment(themeProvider)
                    } label: {
                        ThemeCardView(
                            theme: theme,
                            isActive: themeProvider.currentTheme.id == theme.id,
                            onTap: {
                                withAnimation(motion.slow) {
                                    themeProvider.applyTheme(theme)
                                }
                            }
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, spacing.lg)
        }
    }
}

// MARK: - Info Section

// MARK: - Appearance Mode Section

private struct AppearanceModeSection: View {
    @Environment(ThemeProvider.self) private var themeProvider
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius
    @Environment(\.motion) private var motion

    var body: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            HStack(spacing: spacing.sm) {
                Image(systemName: "circle.lefthalf.filled")
                    .font(.title3)
                    .foregroundStyle(colors.primary)
<<<<<<< HEAD
                
                Text("Appearance")
=======

                Text("外観モード")
>>>>>>> upstream/main
                    .typography(.titleMedium)
                    .foregroundStyle(colors.onSurface)
            }
            .padding(.horizontal, spacing.lg)
<<<<<<< HEAD
            
            Picker("Appearance", selection: Binding(
=======

            Picker("外観モード", selection: Binding(
>>>>>>> upstream/main
                get: { themeProvider.themeMode },
                set: { newMode in
                    withAnimation(motion.slow) {
                        themeProvider.themeMode = newMode
                    }
                }
            )) {
                ForEach(ThemeMode.allCases, id: \.self) { mode in
                    Text(modeLabel(for: mode)).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, spacing.lg)

            Text(modeDescription(for: themeProvider.themeMode))
                .typography(.bodySmall)
                .foregroundStyle(colors.onSurfaceVariant)
                .padding(.horizontal, spacing.lg)
        }
        .padding(.vertical, spacing.md)
        .background(colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: radius.lg))
        .padding(.horizontal, spacing.lg)
    }
    
    private func modeLabel(for mode: ThemeMode) -> String {
        switch mode {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
    
    private func modeDescription(for mode: ThemeMode) -> String {
        switch mode {
        case .system: return "Automatically follows the device appearance settings."
        case .light: return "Always displays in light mode."
        case .dark: return "Always displays in dark mode."
        }
    }
}

private struct InfoSection: View {
    @Environment(ThemeProvider.self) private var themeProvider
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    var body: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("Current configuration")
                .typography(.titleMedium)
                .foregroundStyle(colors.onSurface)
                .padding(.horizontal, spacing.lg)

<<<<<<< HEAD
            VStack(spacing: 0) {
                InfoRow(label: "Theme", value: themeProvider.currentTheme.name)
=======
            VStack {
                InfoRow(label: "テーマ", value: themeProvider.currentTheme.name)
>>>>>>> upstream/main
                Divider().padding(.leading, spacing.lg)
                InfoRow(label: "Mode", value: themeProvider.themeMode.rawValue)
                Divider().padding(.leading, spacing.lg)
                InfoRow(
                    label: "Available themes",
                    value: "\(themeProvider.availableThemes.count)"
                )
            }
            .background(colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: radius.lg))
            .padding(.horizontal, spacing.lg)
        }
    }
}

// Now using shared InfoRow from Catalog/Shared/

#Preview {
    @Previewable @State var themeProvider = ThemeProvider()

    NavigationStack {
        ThemeGalleryView()
            .environment(themeProvider)
    }
    .theme(themeProvider)
}
