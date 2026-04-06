# Creating a Custom Theme

How to create a custom theme with your own brand colors.

## Overview

The DesignSystem theme system uses a protocol-based design.
You can add your own theme by implementing the ``Theme`` and ``ColorPalette`` protocols.

## Step 1: Implement ColorPalette

Create color palettes for light and dark modes:

```swift
struct MyBrandLightPalette: ColorPalette {
    let primary: Color = Color(hex: "007AFF")
    let onPrimary: Color = .white
    let primaryContainer: Color = Color(hex: "007AFF").opacity(0.1)
    let onPrimaryContainer: Color = Color(hex: "007AFF")

    let secondary: Color = Color(hex: "5856D6")
    let onSecondary: Color = .white
    let secondaryContainer: Color = Color(hex: "5856D6").opacity(0.1)
    let onSecondaryContainer: Color = Color(hex: "5856D6")

    let tertiary: Color = Color(hex: "FF9500")
    let onTertiary: Color = .white

    let background: Color = .white
    let onBackground: Color = .black
    let surface: Color = Color(white: 0.98)
    let onSurface: Color = Color(white: 0.1)
    let surfaceVariant: Color = Color(white: 0.95)
    let onSurfaceVariant: Color = Color(white: 0.3)

    let error: Color = .red
    let onError: Color = .white
    let errorContainer: Color = Color.red.opacity(0.1)
    let onErrorContainer: Color = .red
    let warning: Color = .orange
    let onWarning: Color = .white
    let success: Color = .green
    let onSuccess: Color = .white
    let info: Color = .blue
    let onInfo: Color = .white

    let outline: Color = Color(white: 0.8)
    let outlineVariant: Color = Color(white: 0.9)
}
```

## Step 2: Implement Theme Protocol

Implement the ``Theme`` protocol and return the appropriate palette for each mode:

```swift
struct MyBrandTheme: Theme {
    var id: String { "myBrand" }
    var name: String { "My Brand" }
    var description: String { "Custom brand color theme" }
    var category: ThemeCategory { .brandPersonality }
    var previewColors: [Color] {
        [Color(hex: "007AFF"), Color(hex: "5856D6"), Color(hex: "FF9500")]
    }

    func colorPalette(for mode: ThemeMode) -> any ColorPalette {
        switch mode {
        case .system, .light:
            MyBrandLightPalette()
        case .dark:
            MyBrandDarkPalette()
        }
    }
}
```

## Step 3: Register with ThemeProvider

### As Initial Theme

```swift
@State private var themeProvider = ThemeProvider(
    initialTheme: MyBrandTheme()
)
```

### As Additional Theme

```swift
@State private var themeProvider = ThemeProvider(
    additionalThemes: [MyBrandTheme()]
)
```

### Multiple Custom Themes

```swift
@State private var themeProvider = ThemeProvider(
    initialTheme: MyBrandTheme(),
    additionalThemes: [SeasonalTheme(), CampaignTheme()]
)
```

## Topics

### Related

- ``Theme``
- ``ThemeProvider``
- ``ColorPalette``
- ``ThemeMode``
- ``ThemeCategory``
