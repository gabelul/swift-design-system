# DesignSystem

Type-safe, extensible design system for SwiftUI.

![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS%2017.0+%20%7C%20macOS%2014.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## Features

- **3-layer token system** - clear hierarchy: Primitive → Semantic → Component
- **Type-safe** - protocol-based design keeps the system strongly typed and extensible
- **7 built-in themes** - Default, Ocean, Forest, Sunset, PurpleHaze, Monochrome, HighContrast
- **Light / dark mode support** - every theme switches cleanly across modes
- **Rich component set** - Button, Card, Chip, TextField, FAB, Snackbar, ProgressBar, and more

## Installation

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/no-problem-dev/swift-design-system.git", .upToNextMajor(from: "1.0.0"))
]
```

## Quick Start

### Apply a theme

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

### Use design tokens

```swift
struct MyView: View {
    @Environment(\.colorPalette) var colors
    @Environment(\.spacingScale) var spacing

    var body: some View {
        VStack(spacing: spacing.lg) {
            Text("Title")
                .typography(.headlineLarge)
                .foregroundColor(colors.primary)
            Text("Body")
                .typography(.bodyMedium)
                .foregroundColor(colors.onSurface)
        }
        .padding(spacing.xl)
        .background(colors.surface)
    }
}
```

### Components

```swift
// Button
Button("Save") { save() }
    .buttonStyle(.primary)
    .buttonSize(.large)

// Card
Card(elevation: .level2) {
    Text("Card content").typography(.bodyMedium)
}

// Text field
DSTextField("Email", text: $email, placeholder: "example@email.com", leadingIcon: "envelope")
```

### Switch themes

```swift
// Switch to a built-in theme
themeProvider.switchToTheme(id: "ocean")

// Toggle mode (system → light → dark → system)
themeProvider.toggleMode()
```

## Documentation

For detailed guides and the full API reference, see the DocC documentation.

| Guide | Description |
|-------|------|
| [Getting Started](https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/gettingstarted/) | Setup and basic usage |
| [Token Architecture](https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/tokenarchitecture/) | How the 3-layer token system is structured |
| [Custom Theme](https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/customtheme/) | How to create a custom theme |
| [API Reference](https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/) | Full public API |

## Requirements

- iOS 17.0+ / macOS 14.0+
- Swift 6.2+
- Xcode 16.0+

## License

MIT License - see [LICENSE](LICENSE) for details.

## Links

- [Full documentation](https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/)
- [Issue tracker](https://github.com/no-problem-dev/swift-design-system/issues)
- [Discussions](https://github.com/no-problem-dev/swift-design-system/discussions)
- [Release process](RELEASE_PROCESS.md)
