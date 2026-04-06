# ``DesignSystem``

A type-safe, extensible design system for SwiftUI.

## Overview

DesignSystem is a SwiftUI design system library based on a three-layer token architecture:
Primitive → Semantic → Component.
Its protocol-based design achieves both type safety and extensibility.

Applying a theme is straightforward:

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

Inside views, retrieve design tokens from the Environment:

```swift
struct MyView: View {
    @Environment(\.colorPalette) var colors
    @Environment(\.spacingScale) var spacing

    var body: some View {
        VStack(spacing: spacing.lg) {
            Text("Heading")
                .typography(.headlineLarge)
                .foregroundColor(colors.primary)
        }
        .padding(spacing.xl)
    }
}
```

### iOS Only Components

The following components are iOS-only (conditionally compiled with `#if canImport(UIKit)`):

- `VideoPlayerView` - Video player
- `ImagePickerModifier` - Image picker (`.imagePicker()`)
- `VideoPickerModifier` - Video picker (`.videoPicker()`)

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:TokenArchitecture>
- <doc:CustomTheme>
- ``ThemeProvider``
- ``Theme``
- ``ThemeMode``

### Design Tokens

- ``ColorPalette``
- ``SpacingScale``
- ``RadiusScale``
- ``Typography``
- ``Motion``
- ``Elevation``

### Theme System

- <doc:DynamicTheme>
- ``ThemeCategory``
- ``ThemeRegistry``
- ``DynamicTheme``
- ``DefaultTheme``
- ``OceanTheme``
- ``ForestTheme``
- ``SunsetTheme``
- ``PurpleHazeTheme``
- ``MonochromeTheme``
- ``HighContrastTheme``

### Token Defaults

- ``DefaultSpacingScale``
- ``DefaultRadiusScale``
- ``DefaultMotion``

### Components - Button

- ``PrimaryButtonStyle``
- ``SecondaryButtonStyle``
- ``TertiaryButtonStyle``
- ``ButtonSize``

### Components - Input

- ``DSTextField``
- ``DSSecureField``
- ``SearchField``
- ``Chip``
- ``ChipStyle``
- ``ChipSize``
- ``FilledChipStyle``
- ``OutlinedChipStyle``
- ``LiquidGlassChipStyle``

### Components - Display

- ``Card``
- ``Avatar``
- ``AvatarSize``
- ``Badge``
- ``IconBadge``
- ``IconBadgeSize``
- ``StatDisplay``
- ``StatDisplaySize``
- ``ProgressBar``
- ``Accordion``
- ``Skeleton``
- ``SkeletonShape``

### Components - Feedback

- ``Snackbar``
- ``SnackbarState``
- ``SnackbarAction``
- ``Toast``
- ``ToastState``
- ``ToastLevel``
- ``StatusBanner``
- ``StatusBannerLevel``

### Components - Overlay

- ``BottomSheet``
- ``BottomSheetDetent``

### Components - Action

- ``IconButton``
- ``IconButtonStyle``
- ``IconButtonSize``
- ``FloatingActionButton``
- ``FABSize``

### State Views

- ``EmptyState``
- ``ErrorState``
- ``LoadingState``

### Layout Patterns

- ``SectionCard``
- ``AspectGrid``
- ``FlowLayout``
- ``Screen``

### Pickers

- ``EmojiPickerModifier``
- ``IconPickerModifier``
- ``ColorPickerModifier``

### Utilities

- ``ByteSize``
