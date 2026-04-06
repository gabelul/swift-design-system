# Getting Started

Setting up DesignSystem and basic usage.

## Overview

Getting started with DesignSystem takes three steps:
add the package, set up a theme, and start using design tokens.

## Installation

### Swift Package Manager

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/no-problem-dev/swift-design-system.git", .upToNextMajor(from: "1.0.0"))
]
```

Or use Xcode's File > Add Package Dependencies and enter the URL.

## Setup

Configure a ``ThemeProvider`` at the root of your app and apply it with the `.theme()` modifier:

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

This makes design tokens available to all child views.

## Using Design Tokens

### Color Palette

Retrieve ``ColorPalette`` from the Environment:

```swift
struct MyView: View {
    @Environment(\.colorPalette) var colors

    var body: some View {
        Text("Hello")
            .foregroundColor(colors.primary)
            .background(colors.surface)
    }
}
```

### Spacing

Apply consistent spacing with ``SpacingScale``:

```swift
@Environment(\.spacingScale) var spacing

VStack(spacing: spacing.lg) {  // 16pt
    Text("Item 1")
    Text("Item 2")
}
.padding(spacing.xl)  // 24pt
```

### Typography

Apply text styles with the ``Typography`` modifier:

```swift
Text("Headline").typography(.headlineLarge)
Text("Body text").typography(.bodyMedium)
Text("Label").typography(.labelSmall)
```

## Using Components

### Buttons

```swift
Button("Save") { save() }
    .buttonStyle(.primary)
    .buttonSize(.large)

Button("Cancel") { cancel() }
    .buttonStyle(.secondary)
```

### Cards

```swift
Card(elevation: .level2) {
    VStack(alignment: .leading, spacing: spacing.md) {
        Text("Title").typography(.titleMedium)
        Text("Content").typography(.bodyMedium)
    }
}
```

### Text Fields

```swift
DSTextField(
    "Email",
    text: $email,
    placeholder: "example@email.com",
    leadingIcon: "envelope"
)
```

## Switching Themes

Use ``ThemeProvider`` to dynamically switch themes and modes:

```swift
@Environment(ThemeProvider.self) private var themeProvider

// Switch theme
themeProvider.switchToTheme(id: "ocean")

// Toggle mode (cycles: system → light → dark → system)
themeProvider.toggleMode()
```

Seven built-in themes are available:
Default, Ocean, Forest, Sunset, PurpleHaze, Monochrome, HighContrast

### Quick Branding with DynamicTheme

Generate a full palette from a single brand color — no need to define custom palettes:

```swift
@State var themeProvider = ThemeProvider(
    initialTheme: DynamicTheme(brandColor: Color(hex: "#6366F1"))
)
```

See <doc:DynamicTheme> for details on the color derivation algorithm.

## Topics

### Related

- ``ThemeProvider``
- ``Theme``
- ``ColorPalette``
- ``SpacingScale``
- ``Typography``
