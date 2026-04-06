# Dynamic Theme

Generate a complete brand palette from a single color.

## Overview

``DynamicTheme`` takes one brand color and derives a full light/dark color palette
using HSB (Hue, Saturation, Brightness) color space manipulation. This is the
fastest way to brand an app — one color in, complete visual identity out.

```swift
// One line to brand your entire app
@State var themeProvider = ThemeProvider(
    initialTheme: DynamicTheme(brandColor: Color(hex: "#6366F1"))
)
```

## How Colors Are Derived

The algorithm shifts hue and adjusts saturation to generate harmonious colors:

| Role | Derivation |
|------|-----------|
| **Primary** | Brand color as-is |
| **Secondary** | Hue +30°, saturation ×0.8 |
| **Tertiary** | Hue −30°, saturation ×0.9 |
| **Surface** | Brand hue, saturation crushed to ~3–6%, brightness ~95–98% |
| **Background** | Brand hue, saturation ~2%, brightness ~100% |
| **Error** | Fixed red (doesn't shift with brand) |
| **Warning** | Fixed amber |
| **Success** | Fixed green |
| **Info** | Fixed blue |

Dark mode uses the same hue shifts but inverts brightness values for dark surfaces
and boosts primary brightness for visibility.

## Changing the Brand at Runtime

```swift
@Environment(ThemeProvider.self) private var themeProvider

// Switch to a new brand color
themeProvider.applyTheme(
    DynamicTheme(brandColor: .orange, name: "Sunset Brand")
)
```

## Using with ThemeGalleryView

The catalog's Theme Gallery includes a live demo where you can pick any color
and see the full derived palette update in real time.

## Custom Name and ID

```swift
// Give your dynamic theme a custom identity
let theme = DynamicTheme(
    brandColor: Color(hex: "#10B981"),
    name: "Emerald",
    id: "emerald"
)
```

## Topics

### Related

- ``Theme``
- ``ThemeProvider``
- ``ColorPalette``
- ``ThemeMode``
