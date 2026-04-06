# Token Architecture

Design philosophy and usage of the three-layer token system.

## Overview

DesignSystem uses a **Primitive → Semantic → Component** three-layer token architecture.
Each layer has a clear role, and using tokens from the appropriate layer ensures maintainability and consistency.

## Layer 1: Primitive Tokens

Defines raw values (hex color codes, spacing point values, etc.).

> Warning: Primitive Tokens are internal implementation details. Do not use them directly in views.

```swift
// Don't use directly
PrimitiveColors.blue500
PrimitiveSpacing.space16
PrimitiveRadius.radius8
```

## Layer 2: Semantic Tokens

Defines meaningful tokens through protocols.
**Always use this layer** to support theme and mode switching.

Retrieve them from the Environment:

```swift
// Use Semantic Tokens
@Environment(\.colorPalette) var colors
@Environment(\.spacingScale) var spacing
@Environment(\.radiusScale) var radius
@Environment(\.motion) var motion

Text("Hello")
    .foregroundColor(colors.primary)     // Meaning: primary color
    .padding(spacing.lg)                 // Meaning: large padding
```

### Available Semantic Tokens

| Protocol | Environment Key | Description |
|----------|----------------|-------------|
| ``ColorPalette`` | `\.colorPalette` | Color palette (primary, surface, error, etc.) |
| ``SpacingScale`` | `\.spacingScale` | Spacing (10 levels from xxs to xxxl) |
| ``RadiusScale`` | `\.radiusScale` | Corner radius (8 levels from xs to full) |
| ``Motion`` | `\.motion` | Animation timing |

## Layer 3: Component Tokens

Defines component-specific parameters.
Provides optimized value sets for each component.

```swift
// Use Component Tokens
Button("Save") { save() }
    .buttonStyle(.primary)
    .buttonSize(.large)

Card(elevation: .level2) {
    // ...
}

Chip("Tag", style: FilledChipStyle())
    .chipSize(.small)
```

### Available Component Tokens

| Token | Description |
|-------|-------------|
| ``ButtonSize`` | Button size (small / medium / large) |
| ``ChipSize`` | Chip size (small / medium / large) |
| ``Elevation`` | Shadow level (level0 through level5) |

## Topics

### Semantic Token Protocols

- ``ColorPalette``
- ``SpacingScale``
- ``RadiusScale``
- ``Typography``
- ``Motion``

### Component Tokens

- ``ButtonSize``
- ``ChipSize``
- ``Elevation``
