# Brand Recipes

Create one small source of truth for app branding without inventing a second design system.

## Overview

`BrandRecipe` composes the DesignSystem pieces you already have:
- a `Theme` (or `DynamicTheme`)
- a `TypographyProvider`
- a preferred `ScreenDensity`

This keeps setup compact while preserving semantic tokens in feature code.

## Quick Start

```swift
@main
struct MyApp: App {
    private let recipe = BrandRecipe.dynamic(
        brandColor: Color(hex: "#6366F1"),
        sansFontName: "Inter",
        serifFontName: "SourceSerif4",
        typographyScale: 1.0,
        screenDensity: .standard
    )

    @State private var themeProvider: ThemeProvider

    init() {
        _themeProvider = State(initialValue: recipe.makeThemeProvider())
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .installBrandRecipe(recipe, using: themeProvider)
        }
    }
}
```

## When to use `BrandRecipe`

Use it when you want one place to define:
- brand color / theme choice
- font family choices
- global typography scale
- default page density

Do **not** use it to create a second token layer. Feature code should still use:
- `.typography(...)`
- `Screen(...)`
- `colorPalette`, `spacingScale`, `radiusScale`

## Density guidance

`BrandRecipe` installs a preferred `ScreenDensity` for descendant `Screen` views:
- `.compact` — dashboards, feeds, comparisons
- `.standard` — forms, settings, detail flows
- `.spacious` — onboarding, editorial, hero-heavy screens

Pair it with `Screen(padding: .automatic)` so app-owned pages follow the recipe by default.
