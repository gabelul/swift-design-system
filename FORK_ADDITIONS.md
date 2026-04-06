# Fork Additions

What this fork adds on top of the upstream [no-problem-dev/swift-design-system](https://github.com/no-problem-dev/swift-design-system).

**Upstream version:** v1.0.23
**Fork purpose:** English localization + expanded component library for AI-assisted iOS app generation

---

## Translation (all files)

Every Japanese doc comment, code example, and UI string has been translated to English.
Zero Japanese remains in any Swift source file. See commit history for details.

---

## DynamicTheme (new)

Generate a full light/dark color palette from a single brand color using HSB shifts.

**Files added:**
- `Sources/DesignSystem/Extensions/Color+HSB.swift`
- `Sources/DesignSystem/Themes/Dynamic/DynamicTheme.swift`
- `Sources/DesignSystem/Themes/Dynamic/DynamicLightPalette.swift`
- `Sources/DesignSystem/Themes/Dynamic/DynamicDarkPalette.swift`
- `Sources/DesignSystem/Documentation.docc/DynamicTheme.md`

**Usage:** `ThemeProvider(initialTheme: DynamicTheme(brandColor: .indigo))`

---

## New Components (15 total)

### Input Components
| Component | File | What it does |
|-----------|------|-------------|
| **DSSecureField** | `Components/SecureField/DSSecureField.swift` | Password field matching DSTextField styling, with reveal toggle |
| **SearchField** | `Components/SearchField/SearchField.swift` | Search input with magnifying glass, clear button, cancel button |

### Display Components
| Component | File | What it does |
|-----------|------|-------------|
| **Avatar** | `Components/Avatar/Avatar.swift` | Circular image with initials fallback, 4 sizes |
| **Badge** | `Components/Badge/Badge.swift` | Notification dot or count, also `.badge()` ViewModifier |
| **Accordion** | `Components/Accordion/Accordion.swift` | Expandable/collapsible section with animated chevron |
| **Skeleton** | `Components/Skeleton/Skeleton.swift` | Shape placeholder for loading states |
| **ShimmerModifier** | `Components/Skeleton/ShimmerModifier.swift` | `.shimmer()` animation modifier, respects reduce-motion |

### Feedback Components
| Component | File | What it does |
|-----------|------|-------------|
| **Toast** | `Components/Toast/Toast.swift` | Auto-dismissing notification from top (no actions, unlike Snackbar) |
| **ToastState** | `Components/Toast/ToastState.swift` | Observable state manager for Toast |
| **StatusBanner** | `Components/StatusBanner/StatusBanner.swift` | Inline colored banner for info/success/warning/error |

### Overlay Components
| Component | File | What it does |
|-----------|------|-------------|
| **BottomSheet** | `Components/BottomSheet/BottomSheet.swift` | Modal sheet with drag handle, 3 detent heights, `.bottomSheet()` modifier |

### State Views
| Component | File | What it does |
|-----------|------|-------------|
| **EmptyState** | `Components/StateViews/EmptyState.swift` | Icon + title + message + optional action for empty lists |
| **ErrorState** | `Components/StateViews/ErrorState.swift` | Error display with retry button |
| **LoadingState** | `Components/StateViews/LoadingState.swift` | Centered spinner with optional message |

---

## New Layout Helpers (2)

| Layout | File | What it does |
|--------|------|-------------|
| **FlowLayout** | `Layout/FlowLayout.swift` | Wrapping horizontal layout for tags, chips, filters |
| **Screen** | `Layout/Screen.swift` | Scrollable page wrapper with standard padding and background |

---

## Catalog Updates

Every new component has a catalog view in `Catalog/Components/` or `Catalog/Patterns/Layout/`.
The Theme Gallery includes a live DynamicTheme demo with a color picker.

**New catalog views:**
- AccordionCatalogView, AvatarCatalogView, BadgeCatalogView
- BottomSheetCatalogView, EmptyStateCatalogView, ErrorStateCatalogView
- FlowLayoutCatalogView, LoadingStateCatalogView, ScreenCatalogView
- SearchFieldCatalogView, SecureFieldCatalogView, SkeletonCatalogView
- StatusBannerCatalogView, ToastCatalogView

---

## DocC Documentation Updates

- `DesignSystem.md` — updated with all new component references
- `GettingStarted.md` — added DynamicTheme quick-start section
- `DynamicTheme.md` — new article explaining the HSB derivation algorithm

---

## What's NOT Changed

These are untouched and will merge cleanly with future upstream updates:
- All token protocols (ColorPalette, SpacingScale, RadiusScale, Typography, Motion)
- All existing components (Button, Card, Chip, DSTextField, FAB, IconButton, etc.)
- Theme protocol and ThemeProvider
- All 7 built-in themes (Default, Ocean, Forest, Sunset, PurpleHaze, Monochrome, HighContrast)
- Package.swift structure (single target, same dependencies)

---

## Merge Strategy for Future Upstream Updates

1. New upstream components → merge as-is, translate Japanese, add to our catalog
2. Upstream changes to existing components → merge normally, resolve conflicts preserving English
3. Upstream token changes → merge as-is (we don't modify token protocols)
4. Our additions live in new files/directories, so conflicts are rare

**Last synced:** v1.0.23 (April 2026)
