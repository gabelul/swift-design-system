# DesignSystem

Type-safe, extensible design system for SwiftUI.

![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS%2017.0+%20%7C%20macOS%2014.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

📚 **Full documentation (Japanese)**:  
https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/

This file is an English overview of the same library. For the most up‑to‑date and exhaustive API docs, refer to the DocC documentation above.

---

## Features

```swift
// Apply theme
ContentView()
    .theme(themeProvider)

// Color palette
@Environment(\.colorPalette) var colors
Text("Hello").foregroundColor(colors.primary)

// Spacing scale
@Environment(\.spacingScale) var spacing
VStack(spacing: spacing.lg) { /* ... */ }

// Typography
Text("Headline").typography(.headlineLarge)
```

- **3‑layer token system** – clear hierarchy: Primitive → Semantic → Component.
- **Type‑safe** – protocol‑based design makes the system strongly typed and extensible.
- **7 built‑in themes** – Default, Ocean, Forest, Sunset, PurpleHaze, Monochrome, HighContrast.
- **Light/Dark support** – every theme supports smooth light/dark switching.
- **Ready‑made components** – buttons, cards, text fields, chips, icon buttons, FAB, etc.
- **DocC documentation** – practical code examples for all public APIs.

---

## Installation

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/no-problem-dev/swift-design-system.git",
             .upToNextMajor(from: "1.0.0"))
]
```

Or in Xcode:  
`File > Add Package Dependencies…` and enter the repository URL.

---

## Basic Usage

### 1. Setup `ThemeProvider`

```swift
@main
struct MyApp: App {
    @State private var themeProvider = ThemeProvider()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .theme(themeProvider)
        }
    }
}
```

### 2. Use design tokens

#### Colors

```swift
struct MyView: View {
    @Environment(\.colorPalette) var colors

    var body: some View {
        VStack {
            Text("Title")
                .foregroundColor(colors.primary)
            Text("Body")
                .foregroundColor(colors.onSurface)
        }
        .background(colors.surface)
    }
}
```

#### Spacing and layout

```swift
struct MyView: View {
    @Environment(\.spacingScale) var spacing

    var body: some View {
        VStack(spacing: spacing.lg) {  // 16pt
            Text("Item 1")
            Text("Item 2")
        }
        .padding(spacing.xl)  // 24pt
    }
}
```

#### Typography

```swift
Text("Large Headline")
    .typography(.headlineLarge)

Text("Body text")
    .typography(.bodyMedium)

Text("Label")
    .typography(.labelSmall)
```

### 3. Use components

#### Buttons

```swift
Button("Save") { save() }
    .buttonStyle(.primary)
    .buttonSize(.large)

Button("Cancel") { cancel() }
    .buttonStyle(.secondary)
    .buttonSize(.medium)

Button("Delete") { delete() }
    .buttonStyle(.tertiary)
```

#### Card

```swift
Card(elevation: .level2) {
    @Environment(\.spacingScale) var spacing

    VStack(alignment: .leading, spacing: spacing.md) {
        Text("Card Title")
            .typography(.titleMedium)
        Text("Card body text. Use cards to group related content.")
            .typography(.bodyMedium)
    }
}
```

#### SectionCard layout pattern

```swift
ScrollView {
    @Environment(\.spacingScale) var spacing

    VStack(spacing: spacing.xl) {
        SectionCard(title: "General") {
            // Content
        }

        SectionCard(title: "Profile", elevation: .level2) {
            // Content
        }
    }
}
```

---

## Built‑in Themes

You can choose from seven built‑in themes:

```swift
// Switch theme
themeProvider.switchToTheme(id: "default")
themeProvider.switchToTheme(id: "ocean")
themeProvider.switchToTheme(id: "forest")
themeProvider.switchToTheme(id: "sunset")
themeProvider.switchToTheme(id: "purpleHaze")
themeProvider.switchToTheme(id: "monochrome")
themeProvider.switchToTheme(id: "highContrast") // WCAG AAA‑oriented

// Toggle light/dark mode
themeProvider.toggleMode()

// Force a specific mode
themeProvider.themeMode = .dark
```

Theme summary:

| Category       | Theme        | Description                             | Primary Color      |
|----------------|-------------|-----------------------------------------|--------------------|
| Standard       | Default     | Basic light/dark theme                  | Blue #3B82F6       |
| Brand          | Ocean       | Professional, calm                      | Ocean Blue #0077BE |
| Brand          | Forest      | Natural, stable                         | Forest Green #2D5016 |
| Brand          | Sunset      | Warm, energetic                         | Coral Orange #FF6B35 |
| Brand          | PurpleHaze  | Creative, innovative                    | Royal Purple #7209B7 |
| Brand          | Monochrome  | Minimal and elegant                     | Charcoal #2D3748   |
| Accessibility  | HighContrast| Maximum contrast (WCAG AAA‑oriented)    | Pure Black #000000 |

---

## Dynamic Theme Switching

```swift
struct ThemePickerView: View {
    @Environment(ThemeProvider.self) private var themeProvider

    var body: some View {
        VStack(spacing: 16) {
            // Theme picker
            Picker("Theme", selection: Binding(
                get: { themeProvider.currentTheme.id },
                set: { themeProvider.switchToTheme(id: $0) }
            )) {
                ForEach(themeProvider.availableThemes, id: \.id) { theme in
                    Text(theme.name).tag(theme.id)
                }
            }
            .pickerStyle(.menu)

            // Mode toggle
            Toggle("Dark Mode", isOn: Binding(
                get: { themeProvider.themeMode == .dark },
                set: { _ in themeProvider.toggleMode() }
            ))

            // Animated switch
            Button("Switch to Ocean theme") {
                withAnimation {
                    themeProvider.switchToTheme(id: "ocean")
                }
            }
        }
        .padding()
    }
}
```

---

## Creating a Custom Theme

You can build your own brand theme using the protocol‑based token system.

### Step 1: Implement `ColorPalette`

```swift
struct MyBrandColorPalette: ColorPalette {
    let primary: Color
    let onPrimary: Color
    let primaryContainer: Color
    let onPrimaryContainer: Color

    let secondary: Color
    let onSecondary: Color
    let secondaryContainer: Color
    let onSecondaryContainer: Color

    let tertiary: Color
    let onTertiary: Color

    let background: Color
    let onBackground: Color
    let surface: Color
    let onSurface: Color
    let surfaceVariant: Color
    let onSurfaceVariant: Color

    let error: Color
    let warning: Color
    let success: Color
    let info: Color

    let outline: Color
    let outlineVariant: Color

    static let light = MyBrandColorPalette(
        primary: Color(red: 0.0, green: 0.48, blue: 1.0),  // #007AFF
        onPrimary: .white,
        primaryContainer: Color(red: 0.0, green: 0.48, blue: 1.0).opacity(0.1),
        onPrimaryContainer: Color(red: 0.0, green: 0.48, blue: 1.0),

        secondary: Color(red: 0.35, green: 0.34, blue: 0.84),  // #5856D6
        onSecondary: .white,
        secondaryContainer: Color(red: 0.35, green: 0.34, blue: 0.84).opacity(0.1),
        onSecondaryContainer: Color(red: 0.35, green: 0.34, blue: 0.84),

        tertiary: Color(red: 1.0, green: 0.58, blue: 0.0),  // #FF9500
        onTertiary: .white,

        background: .white,
        onBackground: .black,
        surface: Color(white: 0.98),
        onSurface: Color(white: 0.1),
        surfaceVariant: Color(white: 0.95),
        onSurfaceVariant: Color(white: 0.3),

        error: .red,
        warning: .orange,
        success: .green,
        info: .blue,

        outline: Color(white: 0.8),
        outlineVariant: Color(white: 0.9)
    )

    static let dark = MyBrandColorPalette(
        primary: Color(red: 0.04, green: 0.52, blue: 1.0),
        onPrimary: Color(white: 0.1),
        primaryContainer: Color(red: 0.0, green: 0.48, blue: 1.0).opacity(0.2),
        onPrimaryContainer: Color(red: 0.5, green: 0.7, blue: 1.0),

        secondary: Color(red: 0.45, green: 0.44, blue: 0.94),
        onSecondary: Color(white: 0.1),
        secondaryContainer: Color(red: 0.35, green: 0.34, blue: 0.84).opacity(0.2),
        onSecondaryContainer: Color(red: 0.6, green: 0.58, blue: 0.95),

        tertiary: Color(red: 1.0, green: 0.68, blue: 0.3),
        onTertiary: Color(white: 0.1),

        background: Color(white: 0.05),
        onBackground: Color(white: 0.95),
        surface: Color(white: 0.12),
        onSurface: Color(white: 0.9),
        surfaceVariant: Color(white: 0.18),
        onSurfaceVariant: Color(white: 0.7),

        error: Color(red: 1.0, green: 0.4, blue: 0.4),
        warning: Color(red: 1.0, green: 0.7, blue: 0.3),
        success: Color(red: 0.4, green: 0.9, blue: 0.4),
        info: Color(red: 0.5, green: 0.7, blue: 1.0),

        outline: Color(white: 0.3),
        outlineVariant: Color(white: 0.2)
    )
}
```

### Step 2: Implement `Theme`

```swift
struct MyBrandTheme: Theme {
    var id: String { "myBrand" }
    var name: String { "My Brand" }
    var description: String { "Theme based on our brand colors." }
    var category: ThemeCategory { .brandPersonality }
    var previewColors: [Color] {
        [
            Color(red: 0.0, green: 0.48, blue: 1.0),
            Color(red: 0.35, green: 0.34, blue: 0.84),
            Color(red: 1.0, green: 0.58, blue: 0.0)
        ]
    }

    func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            return MyBrandColorPalette.light
        case .dark:
            return MyBrandColorPalette.dark
        }
    }
}
```

### Step 3: Register in `ThemeProvider`

```swift
@main
struct MyApp: App {
    @State private var themeProvider = ThemeProvider(
        initialTheme: MyBrandTheme(),
        additionalThemes: []
    )

    var body: some Scene {
        WindowGroup {
            ContentView()
                .theme(themeProvider)
        }
    }
}
```

---

## Token Architecture

This library uses a 3‑layer token architecture:

1. **Primitive Tokens** – raw values (HEX colors, spacing in points, radius in points).  
   These are internal implementation details; avoid using them directly.

   ```swift
   PrimitiveColors.blue500      // ❌ Don’t use directly
   PrimitiveSpacing.space16     // ❌ Don’t use directly
   ```

2. **Semantic Tokens** – meaningful tokens such as `primary`, `surface`, `onSurface`, etc.  
   Exposed via protocols like `ColorPalette`, `SpacingScale`, `RadiusScale`, `Typography`.

   ```swift
   @Environment(\.colorPalette) var colors   // ✅
   @Environment(\.spacingScale) var spacing  // ✅
   ```

3. **Component Tokens** – component‑specific tokens like `ButtonSize` or `Elevation`.

   ```swift
   .buttonSize(.large)                  // ✅
   Card(elevation: .level2) { ... }     // ✅
   ```

---

## Key APIs

### Token Protocols (Semantic)

- `ColorPalette` – semantic color palette.
- `SpacingScale` – spacing scale.
- `RadiusScale` – corner radius scale.
- `Typography` – typography tokens.

### Component Tokens

- `ButtonSize` – button size variants.
- `Elevation` – shadow depth levels.

### Theme System

Core types:

- `ThemeProvider` – manages current theme and mode (light/dark/system) with `@Observable` support.
- `Theme` – theme protocol.
- `ThemeMode` – light/dark/system enum.
- `ThemeCategory` – standard/brand/accessibility categories.
- `ThemeRegistry` – registry of built‑in themes.

Built‑in themes:

- `DefaultTheme`
- `OceanTheme`
- `ForestTheme`
- `SunsetTheme`
- `PurpleHazeTheme`
- `MonochromeTheme`
- `HighContrastTheme`

Each theme has light/dark color palettes and uses `DefaultSpacingScale` / `DefaultRadiusScale`.

### Components

- Buttons: `PrimaryButtonStyle`, `SecondaryButtonStyle`, `TertiaryButtonStyle`, `TextButtonStyle`
- `Card` – generic card component
- `IconButton` – icon‑only buttons
- `FloatingActionButton` – FAB
- `Chip` – compact label chips
- `DSTextField` – themed text fields
- `Snackbar` – temporary notification component

### Layout Patterns

- `SectionCard` – section container with title.
- `AspectGrid` – grid layout with fixed aspect ratio.

### View Modifiers

- `.theme(_:)` – apply theme provider to a view hierarchy.
- `.buttonSize(_:)` – set button size.
- `.typography(_:)` – apply typography tokens.

---

## Example Screens

The included catalog app (`DesignSystemCatalog`) contains more complete examples:

- Login screen with themed colors, spacing, and typography.
- Settings screen built with `SectionCard` and tokens.
- Full motion, typography, spacing, and color catalogs.

For deeper details and any updates, please refer to the DocC documentation linked at the top.

