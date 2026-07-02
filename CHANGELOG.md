# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

None

## [1.7.0] - 2026-06-14

### Added
- Added `source: ImagePickerSource` (`.automatic` / `.camera` / `.photoLibrary`) to `imagePicker`.
  Passing `.camera` presents the camera directly without the chooser (for camera-only buttons).
  Defaults to `.automatic`, preserving existing behavior (non-breaking).

## [1.6.0] - 2026-06-14

### Added
- **Attachment UI atoms**: `AttachmentThumbnail` (image/file thumbnail + ✕ delete) and
  `AttachmentStrip` (a horizontally scrolling, logic-less layout container that only accepts a
  ViewBuilder). Neither holds domain types, IO, or state — deletion is handled via callback.
  Added an Attachment section to the Catalog.

## [1.3.2] - 2026-06-07

### Added
- **StatusIndicator component** — a single-glyph indicator for async task state
  - Maps `StatusKind` (pending / running / success / failure / canceled) to semantic colors
  - `StatusKind.color(in:)` lets surrounding elements (badges, etc.) match the indicator's color
  - Shows the system `ProgressView` while running; each state gets an automatic accessibilityLabel
- **StepIndicator component** — a row of dots marking progress across N steps
  - Current = primary, passed = light primary, future = outlineVariant
  - `currentIndex: nil` means all steps are complete; auto-generates a "Step N of M" accessibility label
- **TimelineRow component** — a single row in a chronological feed (activity log)
  - Marker + vertical connector line on the left, arbitrary content on the right; `VStack(spacing: 0)` produces a continuous timeline
  - The marker can be a `StatusIndicator` (via `status:`) or any view (via the `marker:` closure)
- **LinkCard component** — a card for URL references (sources, related links)
  - Title + domain + optional accessory (Chip, etc.); tappable when an `action` is supplied
  - Metadata fetching is the caller's responsibility (no `LinkPresentation` dependency)
- **EmptyState component** — an explicit state for empty lists and empty search results
  - Icon + heading + optional description; uses `accessibilityElement(children: .combine)`
- Added a Catalog section for each of the five components above

## [1.1.0] - 2026-07-02

### Added
- `TypographyProvider.serifTokens` — a `Set<Typography>` letting an app declare
  which typography tokens render serif by default, instead of hand-typing
  `design: .serif` at every call site. Empty by default, so existing consumers
  are unchanged; an explicit `design:` at the call site still overrides. Threaded
  through `BrandRecipe.dynamic(serifTokens:)`. Typical use: pass the display tier
  (`[.displayLarge, .displayMedium, .displaySmall]`) to give an app one editorial
  serif voice for titles app-wide.

### Changed
- `Typography` now conforms to `Sendable` (required for `Set<Typography>` inside
  the `Sendable` `TypographyProvider` under strict concurrency).

## [1.0.24-fork] - 2026-04-15

Merged upstream v1.0.24 into the English fork. All new Japanese docs, comments,
and preview strings translated to English. Fork-only components (DynamicTheme,
Accordion, Avatar, Badge, BottomSheet, DSSecureField, EmptyState, ErrorState,
LoadingState, SearchField, Skeleton, StatusBanner, Toast, Notifications,
FlowLayout, Screen) preserved unchanged.

### Added
- **Section component family** — surface cards for settings and hub screens (ADR-014 upstream)
  - `SectionCard(_ header:, footer:)` — small uppercase header + rounded surface + footer caption
  - `SectionRow` — HStack row with unified padding. `contentShape(Rectangle())` makes the padding tappable too
  - `SectionRowDivider` — 0.5pt hairline divider in `outlineVariant`
  - `SectionNavigationLabel` — chevron label for `NavigationLink`
  - All four built on DS tokens only (spacing / radius / typography / colorPalette)
  - Works as a plain-SwiftUI stand-in for the iOS 26 Liquid Glass surface material look

### Changed
- **SectionCard** — existing `SectionCard(title:, elevation:)` initializer kept for backwards compatibility.
  New code should use the `SectionCard(_ header:, footer:)` Surface Section style.
- Moved `Sources/DesignSystem/Layout/Patterns/SectionCard.swift` → `Sources/DesignSystem/Components/Section/SectionCard.swift` (unified with the new Section family, avoids duplicate-type errors).
- Extended `SectionCardCatalogView` with Surface Section demos covering Row, Divider, and NavigationLabel.

## [1.0.22] - 2026-01-06

### Added
- **IconBadge component** — a badge that shows an SF Symbol icon on a circular background (#36)
  - Four sizes: small (24pt), medium (32pt), large (48pt), extraLarge (64pt)
  - Customizable foreground and background colors
  - Well suited for status indicators, feature highlights, and category icons
  - Added an "IconBadge" section to the Catalog

- **ProgressBar component** — a horizontal progress indicator (#36)
  - Progress display with spring animation
  - Customizable height and color
  - Supports an indeterminate state
  - Well suited for loading progress, completion status, and goal tracking
  - Added a "ProgressBar" section to the Catalog

- **StatDisplay component** — a metric display component (#36)
  - Shows a label, value, and optional unit
  - Choice of vertical or horizontal layout
  - Supports a trend indicator (up/down arrow)
  - Well suited for dashboard stats, metric cards, and KPI displays
  - Added a "StatDisplay" section to the Catalog

### Changed
- **Large-scale Catalog app refactor**
  - Introduced shared components: CatalogPageContainer, CatalogOverview, VariantShowcase, CodeExample
  - Migrated 22 catalog detail views to a unified structure
  - Unified the navigation structure: Foundation, Components, and Patterns now share the same list view pattern
  - Unified row rendering via CatalogItemRowContent

- **Completed migration to design tokens**
  - Replaced hardcoded spacing values (1, 2, 4, 6) with spacing tokens (xxs, xs, sm, md)
  - Replaced hardcoded radius values (4, 6, 8, 12) with radius tokens (xs, sm, md, lg)
  - Replaced hardcoded colors (Color.green, Color.red, etc.) with semantic colors (colors.success, colors.error, etc.)
  - Replaced hardcoded fonts with typography tokens
  - Replaced hardcoded animations with motion tokens

- **Simplified the Card component** (#36)
  - Switched to a simpler implementation using @ViewBuilder
  - Removed redundant internal state management

### Removed
- **CatalogItem.swift** — removed a redundant intermediate layer
- **PatternType.swift** — removed as unused
- The `CatalogCategory.items` property — folded into a direct property on CatalogCategory
- The `item` parameter of `CatalogRouter.destination(for:item:)` — removed as unused

## [1.0.21] - 2025-12-21

### Added
- **VideoPicker component** — a modifier for picking video from the camera or video library (#34)
  - Simple API via the `.videoPicker()` ViewModifier
  - Unified UI for camera capture and video library selection
  - Comprehensive permission handling (camera, microphone, photo library)
  - High-quality capture settings (1920x1080, typeHigh)
  - Full-screen camera presentation on iPad
  - File size limit (`maxSize: ByteSize`)
  - Recording duration limit (`maxDuration: TimeInterval`)
  - Error handling via the `onError` callback
  - Added a "VideoPicker" section to the Catalog

- **VideoPlayerView component** — a video playback player (#34)
  - Plays video from `Data` or a `URL`
  - Native full-screen support via AVPlayerViewController
  - Displays metadata (duration, resolution, file size)
  - Action Chip controls (play/pause, share, save)
  - Save-to-Camera-Roll support (permission handling, Snackbar feedback)
  - Automatic audio session configuration
  - Automatic cleanup of temporary files
  - Added a "VideoPlayer" section to the Catalog

- **ByteSize type** — a type-safe utility for working with file sizes (#34)
  - Intuitive size expressions via `Int.kb`, `Int.mb`, `Int.gb` extensions
  - Human-readable formatted output (the `formatted` property)
  - Comparison operator support

- **Action Chip** — a Chip variant with a tap action (#34)
  - The `Chip(label, systemImage:, action:)` initializer
  - Clearly distinguished from the deletable Chip variant

### Changed
- **Improved the ImagePicker API** (#34)
  - Renamed `maxSizeInBytes: Int` to `maxSize: ByteSize` (breaking change)
  - More intuitive file size expressions (e.g. `50.mb`)

### Fixed
- **Improved video capture quality on iPad** (#34)
  - Set `videoQuality = .typeHigh` and `videoExportPreset = AVAssetExportPreset1920x1080`
  - Switched to full-screen camera presentation (previously a sheet)

- **Fixed a crash when saving video** (#34)
  - Resolved a MainActor isolation issue (using a `@Sendable` closure)
  - Added a file-existence check
  - Prevented the temporary file from being deleted while the save was in progress

## [1.0.20] - 2025-11-17

### Added
- **IconPicker, EmojiPicker, and ColorPicker components** — three picker modifiers for selection UI (#32)
  - **IconPicker (SF Symbols only)**
    - Simple API via the `.iconPicker()` ViewModifier
    - Correct SF Symbols rendering via `Image(systemName:)`
    - Category-based organization (IconCategory/IconItem)
    - Half-modal presentation (`.medium`, `.large` detents)
    - Search and category filtering
    - Visual feedback for the selected state
  - **EmojiPicker (emoji only)**
    - Simple API via the `.emojiPicker()` ViewModifier
    - Displays emoji at a larger font size (32pt)
    - Category-based organization (EmojiCategory/EmojiItem)
    - Half-modal presentation (`.medium`, `.large` detents)
    - Search and category filtering
    - Categories such as faces & emotion, animals & nature, food, and activities
  - **ColorPicker (preset colors)**
    - Simple API via the `.colorPicker()` ViewModifier
    - Preset color system (ColorPreset)
    - `.tagFriendly`: 10 colors suited to tags and categories
    - `.allPrimitives`: the full set of primitive colors
    - Half-modal presentation (`.medium`, `.large` detents)
    - Search and category filtering
  - Shared across all pickers
    - Consistent API via the ViewModifier pattern
    - Half-modal sheet (using `.presentationDetents`)
    - Tab navigation by category
    - Filtering via a search field
    - Select/cancel button placement
    - Full integration with design system tokens
  - Added three new sections to the Catalog
    - ColorPickerCatalogView: color picker demos and usage examples
    - EmojiPickerCatalogView: emoji picker demos and usage examples
    - IconPickerCatalogView: icon picker demos and usage examples

## [1.0.19] - 2025-11-17

### Added
- **ImagePicker component** — a modifier for picking images from the camera and photo library (#28)
  - Simple API via the `.imagePicker()` ViewModifier
  - Unified UI for camera capture and photo library selection
  - Comprehensive permission handling (camera and photo library)
  - Minimal-privilege access via the `.addOnly` permission level
  - Camera-availability check (for devices without one, like some iPads)
  - Image compression strategy (the `maxSizeInBytes` parameter)
    - Recursive quality adjustment to hit the target size
    - Skips compression when already under the limit
  - Error handling via the `onCompressionError` callback
  - Explicit handling of the `.restricted` state (MDM/parental controls)
  - Returns image data in JPEG format
  - Added an "ImagePicker" section to the Catalog

- **Snackbar component** — a Material Design–compliant transient notification UI (#26)
  - A transient notification shown from the bottom of the screen
  - `@Observable`-based state management via `SnackbarState`
  - Auto-dismiss (5 seconds by default, customizable)
  - Supports up to two action buttons (primary, secondary)
  - Show/hide transitions with spring animation
  - Accessibility support (accessibilityLabel)
  - Full integration with design system tokens (color, spacing, radius)
  - Added a "Snackbar" section to the Catalog

## [1.0.18] - 2025-11-16

### Added
- **Snackbar component** — a Material Design–compliant transient notification UI (#26)
  - A transient notification shown from the bottom of the screen
  - `@Observable`-based state management via `SnackbarState`
  - Auto-dismiss (5 seconds by default, customizable)
  - Supports up to two action buttons (primary, secondary)
  - Show/hide transitions with spring animation
  - Accessibility support (accessibilityLabel)
  - Full integration with design system tokens (color, spacing, radius)
  - Added a "Snackbar" section to the Catalog

## [1.0.17] - 2025-11-09

### Added
- **Implemented the typography token system** (#23)
  - Flexible font management via the `Typography.Font.Design` protocol
  - Japanese font-switching support
    - `JapaneseRoundedFontDesign`: SF Rounded (rounded gothic) style
    - `JapaneseSerifFontDesign`: Yu Mincho (serif) style
  - Dynamic font switching via `FontDesignProvider`
  - Added a "Typography" section to the Catalog
  - Implemented font style previews and a font-design switching UI

- **Implemented iPad Split View support** (#24)
  - Adaptive layout through a comprehensive refactor
  - Screen-size awareness via `AdaptiveLayoutProvider`
  - Dynamic layout adjustment via `LayoutContext`
  - Updated every Catalog view to support iPad Split View
  - Optimized spacing and layout for Compact/Regular widths

## [1.0.16] - 2025-11-09

### Added
- **Motion system** — a unified animation timing system (#20)
  - 10 tuned animation timings
  - Micro-interactions: `quick` (70ms), `tap` (110ms)
  - State changes: `toggle`, `fadeIn`, `fadeOut` (150ms)
  - Transitions: `slide` (240ms), `slow` (300ms), `slower` (375ms)
  - Springs: `spring`, `bounce`
  - Aligned with industry standards from Material Design 3, IBM Carbon, and Apple HIG
  - Easy to apply via the `.animate()` modifier
  - Automatic Reduce Motion support (WCAG 2.1 SC 2.3.3 compliant)
  - Sendable-conformant and concurrency-safe

- **Motion catalog view** — a comprehensive animation catalog (#20)
  - Overview section: system description and key features
  - Interactive demos: hands-on animations across 4 categories
  - Spec table: detailed specs for all 10 motions
  - Usage examples: 3 code-example patterns
  - Accessibility notes: automatic Reduce Motion support
  - Best practices: recommended patterns and anti-patterns
  - MotionDemoCard: responsive design using the AspectGrid pattern

### Changed
- **Improved the Catalog UI** (#21)
  - Increased inter-section spacing from 24pt to 32pt (aligned with 2025 design system best practices)
  - Introduced a card-like section design (subtle elevation effect)
  - No rounded corners on full-bleed sections (edge-to-edge, the standard iOS pattern)
  - Rounded corners on info sections (a floating card look)
  - Researched and applied 2025 best practices from Material Design 3, Fluent 2, and Carbon Design System

- **Migrated existing components to the Motion system** (#20)
  - Button styles (Primary, Secondary, Tertiary) → now use Motion tokens
  - Chip styles (Filled, Outlined, LiquidGlass) → now use Motion tokens
  - ThemeGalleryView → now uses Motion tokens

- **Dark mode support for custom themes** (#21)
  - Added full dark mode support to `SimpleBlueTheme` and `SimpleRedTheme`
  - Properly handles every `ThemeMode` case (`.system`, `.light`, `.dark`)
  - Adjusted to lighter tones in dark mode to preserve contrast

### Fixed
- **Updated the Xcode environment for GitHub Actions** (#19)
  - macOS 15 → macOS 26 (arm64)
  - Xcode 16.1 → Xcode 26.0.1
  - Added iOS 26 SDK support (required for the `.glassEffect()` API)
  - Resolved a compilation error in the DocC deployment

### Documentation
- **Substantially improved the custom theme documentation** (#21)
  - Added detailed DocC comments to `SimpleBlueTheme` and `SimpleRedTheme`
  - Reworked the "Creating a Custom Theme" section of README.md
    - Step 1: Implementing ColorPalette (a complete example covering all 27 colors)
    - Step 2: Implementing the Theme protocol
    - Step 3: Registering with ThemeProvider (3 patterns)
    - Step 4: Example theme-switching implementation
  - Added documentation to the entry point

## [1.0.15] - 2025-11-09

### Added
- **Chip component** — conforms to the Material Design 3 and Liquid Glass design languages (#15)
  - Protocol-based ChipStyle system (mirrors ButtonStyle)
  - Size variants: Small (24pt), Medium (32pt)
  - Four initializer patterns: static, with icon, deletable, selectable
  - Interactive states: pressed, selected
  - Full accessibility support
  - Three style variants:
    - **Filled**: 10–20% opacity background (for status/category labels)
    - **Outlined**: 1.5pt border (for filters and secondary categories)
    - **Liquid Glass**: native iOS 26+ `.glassEffect()` API (with interactive support)
  - Swift 6 concurrency support (every style conforms to `Sendable`; `@MainActor` methods)
  - Integrated with the token system (built on the three-layer token architecture)

- **AspectGrid layout pattern** — a fixed-aspect-ratio grid layout (#16)
  - **GridSpacing tokens**: five spacing steps — xs, sm, md, lg, xl
  - **Adaptive sizing**: automatically adjusts to screen size (minItemWidth, maxItemWidth)
  - **Covers common use cases**: product listings, photo galleries, video thumbnails
  - **Supported aspect ratios**:
    - 1:1 — product thumbnails, profile images, icons
    - 3:4 — photos, portraits
    - 16:9 — video thumbnails, wide content
  - Efficient rendering built on LazyVGrid
  - Automatic column adjustment via GridItem.adaptive
  - Complete documentation comments and code examples

- **Custom theme category** — extends theme classification (#17)
  - Added a new `.custom` category
    - Name: "Custom"
    - Description: "App-specific custom themes"
    - Icon: `wand.and.stars` ✨
  - The theme gallery now clearly distinguishes built-in themes from custom ones
  - Example custom theme implementations (SimpleBlueTheme, SimpleRedTheme)

### Fixed
- **Improved dynamic theme switching** (#17)
  - Fixed reactive updates in `ThemeEnvironmentView`
    - Problem: the color palette was evaluated statically and didn't update on theme switch
    - Fix: added a `resolvedColorPalette` computed property that takes advantage of `@Observable` change detection
  - Improved dynamic theme display in `ThemeGalleryView`
    - Problem: it used `ThemeRegistry.themesByCategory` (built-in themes only)
    - Fix: now uses `themeProvider.availableThemes` to dynamically show built-in plus custom themes
  - Reactive system: automatic updates driven by `@Observable` and computed properties
  - Extensibility: designed so custom themes can be added easily
  - Initial theme selection: the `initialTheme` parameter controls the theme at launch

## [1.0.14] - 2025-11-08

### Fixed
- **Made automated PR creation reliable (final version)** — added a timestamp comment
  - Added an auto-generated timestamp comment at the end of CHANGELOG.md
  - Guarantees a diff even when the comparison link already has the correct value
  - Ensures a commit is always created so PR creation succeeds

## [1.0.13] - 2025-11-08

### Fixed
- **Improved release note generation** — installation examples now use a dynamic version
  - Replaced the hardcoded "1.0.0" with the actual release version
  - Provides more accurate, clearer installation instructions
- **Made automated PR creation reliable** — added logic to update the CHANGELOG comparison link
  - Always updates the comparison link to the latest version after a release
  - Ensures a commit is created even when the "Unreleased" section already exists
  - Improved so the draft PR for the next release is reliably created

## [1.0.12] - 2025-11-08

### Fixed
- **Consolidated the release workflow** — merged GitHub Release creation into auto-release-on-merge.yml
  - GitHub Release is now created at the same time as the tag
  - Removed the release.yml workflow (functionality merged in)
  - No longer requires a PAT (Personal Access Token)
  - Fully automated end to end using only GITHUB_TOKEN

### Documentation
- **Substantially simplified RELEASE_PROCESS.md** — trimmed down to the essentials
  - Removed redundant sections
  - Simplified the release procedure to 6 steps
  - Pared troubleshooting down to the essentials

## [1.0.11] - 2025-11-08

### Changed
- **Completely revised the release workflow** — switched to a simpler, more intuitive flow
  - Merging a PR from a release branch (`release/vX.Y.Z`) into main now triggers the release
  - Tags are created automatically, so manual tag creation is no longer needed
  - The next release branch and its draft PR are also created automatically
  - Workflow: added `auto-release-on-merge.yml`, removed `prepare-next-release.yml`

### Documentation
- **Fully updated RELEASE_PROCESS.md for the new workflow**
  - Added an overview of the new development flow
  - Organized the detailed procedure into 6 steps
  - Reworked the automation section (a detailed explanation of `auto-release-on-merge.yml`)
  - Updated troubleshooting for the new workflow

## [1.0.10] - 2025-11-08

### Documentation
- **Comprehensive update to the release process guide**
  - Documented the release philosophy and concepts in detail (rationale for the hybrid approach, semantic versioning, Keep a Changelog)
  - Added detailed procedures and a full workflow overview
  - Best practices for writing CHANGELOG.md (good vs. bad examples)
  - Technical explanation of the automation (release.yml, prepare-next-release.yml)
  - Expanded the troubleshooting guide
  - Added a developer info section to README.md
  - Removed the old docs directory (content already consolidated)

## [1.0.9] - 2025-11-08

### Added
- **Automatic comparison link updates** — improvements to the prepare-next-release workflow
  - Automatically extracts the version from the tag
  - Automatically updates the [Unreleased] comparison link to the latest version
  - Removes the need to update links by hand after a release

## [1.0.8] - 2025-11-08

### Fixed
- **Verified the prepare-next-release workflow** — confirmed automatic draft PR creation
  - Verified the PR creation flow for when no "Unreleased" section exists

## [1.0.7] - 2025-11-08

### Changed
- **Improved the release workflow** — added boilerplate and metadata to GitHub Releases
  - Auto-generates the release title, installation instructions, and links
  - Switched to a clearer release notes format

### Fixed
- **prepare-next-release workflow** — implemented automatic draft PR creation
  - Switched to a tag-push trigger (the release:published event doesn't fire reliably)
  - Fully automated through draft PR creation

## [1.0.6] - 2025-11-08

### Added
- Documentation improvements and release flow verification

## [1.0.5] - 2025-11-08

### Added
- **Automation workflow** — automates post-release prep
  - Added `.github/workflows/prepare-next-release.yml`
  - Automatically drafts the next release-prep PR after a GitHub Release is published
  - Automatically inserts an "Unreleased" section into CHANGELOG.md
  - Implemented per Keep a Changelog best practices

## [1.0.4] - 2025-11-08

### Changed
- **Improved the release process** — adopted a hybrid approach
  - CHANGELOG.md is maintained by hand (keeps the Keep a Changelog format)
  - GitHub Releases are generated automatically from tags
  - Redesigned correctly around established best practices

### Removed
- Removed the incorrect automation workflow `prepare-next-version.yml`
- Removed the unnecessary script `prepare_next_version.sh`
- Removed the outdated document `RELEASE_AUTOMATION.md`

### Added
- New release workflow `.github/workflows/release.yml`
  - Extracts the matching version from CHANGELOG.md on tag push
  - Automatically creates the GitHub Release
- Comprehensive release process guide `docs/RELEASE_PROCESS.md`

## [1.0.3] - 2025-11-08

### Documentation
- Changed the installation method in README.md to `upToNextMajor`, aligning with semantic versioning best practices

## [1.0.2] - 2025-11-08

### Added
- **Multi-theme system** — added 7 built-in themes
  - Default — the Material Design 3–compliant default theme
  - Ocean — a calm theme based on ocean blue
  - Forest — a natural theme based on forest green
  - Sunset — a warm theme based on sunset orange
  - Purple Haze — a creative theme based on vivid purple
  - Monochrome — a minimal grayscale theme
  - High Contrast — a WCAG AAA–compliant high-contrast theme
- **Theme architecture**
  - `Theme` protocol — a protocol-oriented, highly extensible theme system
  - `ThemeMode` — supports 3 modes: follow system / light-locked / dark-locked
  - `ThemeCategory` — logical theme classification (Standard, Brand Personality, Accessibility)
  - `ThemeRegistry` — centralized management of all themes
  - Light/Dark palette implementations for every theme (14 palettes total)
- **Catalog app UI**
  - `ThemeGalleryView` — theme list grouped by category
  - `ThemeDetailView` — theme detail with an interactive preview
  - `ThemeCardView` — a theme selection card
  - `ThemeColorPreview` — displays the full 27-color palette
  - `AppearanceModeSection` — appearance mode switching UI
- **DesignSystemCatalogApp** — the Catalog application as its own Xcode project

### Changed
- **Complete rewrite of ThemeProvider** (breaking change)
  - Migrated to the `@Observable` macro
  - Changed initialization parameters:
    - Old: `ThemeProvider(colorScheme:lightPalette:darkPalette:)`
    - New: `ThemeProvider(initialTheme:initialMode:additionalThemes:)`
  - Changed the environment injection method:
    - Old: `.environment(\.themeProvider, provider)`
    - New: `.environment(provider)`
  - Changed the default mode to `.system` (follows the system setting)
- **Improved ThemeModifier**
  - Implemented ColorScheme resolution logic for `ThemeMode.system`
  - Selects the correct palette by coordinating with `@Environment(\.colorScheme)`
- **Improved DesignSystemCatalogView**
  - Removed a redundant header section
  - Changed the navigation title to "Design System Catalog"
  - Added links to the repository and documentation in the info section
  - Removed the version and design system description (reduces maintenance overhead)

### Fixed
- **Unified hardcoded colors in Catalog views under the theme system**
  - Unified header icon colors in PatternsCatalogView/ComponentsCatalogView to `colorPalette.primary`
  - Made the FeatureRow component theme-aware (removed the `color` parameter)
  - Made the visual demos in RadiusDemoView/SpacingDemoView theme-color-aware
  - Unified ButtonCatalogView's description text and background color to ColorPalette tokens
  - Unified `.primary`/`.secondary`/`.tertiary` in ColorSwatchView to `colorPalette` tokens
  - Removed SwiftUI native semantic colors from every Catalog view in favor of full Material Design 3 compliance

### Removed
- `ThemeProviderKey` — no longer needed after migrating to @Observable
- The custom-EnvironmentKey pattern for injecting ThemeProvider

### Documentation
- Added comprehensive multi-theme system documentation to README.md
  - A table describing the character and use case of each of the 7 themes
  - Usage examples for theme switching and mode selection
  - A custom theme creation guide
- Added detailed documentation comments to every theme file
- Added practical code examples to ThemeProtocol/ThemeRegistry/ThemeMode/ThemeCategory

## [1.0.1] - 2025-01-08

### Fixed
- Removed the explicit StrictConcurrency setting since Swift 6 now enables it by default
- Removed the unnecessary swiftSettings entry in Package.swift, resolving a build error

## [1.0.0] - 2025-01-08

### Added
- Three-layer design token system (Primitive, Semantic, Component)
- Protocol-based color palette (`ColorPalette`)
  - Default Light/Dark theme implementations
  - Primary, Secondary, Tertiary color schemes
  - Semantic state colors (Error, Warning, Success, Info)
- Spacing scale (`SpacingScale`)
  - T-shirt-size naming convention (xs, sm, md, lg, xl, etc.)
  - 11 steps from none (0pt) to xxxxl (96pt)
- Radius scale (`RadiusScale`)
  - 7 steps from xs (2pt) to xxl (24pt)
  - `full` (perfect circle) support
- Typography system (`Typography`)
  - 5 categories: Display, Headline, Title, Body, Label
  - 14 predefined text styles
  - Easy to apply via the `.typography()` modifier
- Dynamic theme switching via ThemeProvider
  - Light/Dark/custom theme support
  - Reactive updates via `@Observable`
  - Follows the system theme
- Button components
  - PrimaryButtonStyle — for primary actions
  - SecondaryButtonStyle — for secondary actions
  - TertiaryButtonStyle — for low-emphasis actions
  - TextButtonStyle — a text-only button
  - Unified sizing via ButtonSize (Large, Medium, Small)
- Card components
  - Card — a general-purpose card container
  - Shadow management via Elevation levels (Level0–3)
- IconButton — an icon-based button
- FloatingActionButton (FAB) — a primary-action button
- DSTextField — a design-system-integrated text field
  - Error state and focus state support
  - Placeholder and keyboard type configuration
  - Secure text entry support
- Layout patterns
  - SectionCard — a titled card section
- View modifiers
  - `.theme(_:)` — applies a ThemeProvider
  - `.buttonSize(_:)` — sets a button size
  - `.typography(_:)` — applies typography
- Custom theme creation support
  - Implement your own color palette
  - Custom spacing and radius scales
- Color initialization from a hex string (`Color(hex:)`)
  - Supports 3-digit, 6-digit, and 8-digit (with alpha) formats
- Full documentation comments
  - Practical code examples on every public API
  - User-facing usage guides

### Documentation
- Comprehensive README.md
  - Quick start guide
  - Design token usage examples
  - Custom theme creation example
  - Login screen and settings screen implementation examples
- API reference
- Architecture guide (the three-layer token system)
- DocC support
  - Automatic documentation publishing via GitHub Pages

[Unreleased]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.22...HEAD
[1.0.22]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.21...v1.0.22
[1.0.21]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.20...v1.0.21
[1.0.20]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.19...v1.0.20
[1.0.19]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.18...v1.0.19
[1.0.18]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.17...v1.0.18
[1.0.17]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.16...v1.0.17
[1.0.16]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.15...v1.0.16
[1.0.15]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.14...v1.0.15
[1.0.14]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.13...v1.0.14
[1.0.13]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.12...v1.0.13
[1.0.12]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.11...v1.0.12
[1.0.11]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.10...v1.0.11
[1.0.10]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.9...v1.0.10
[1.0.9]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.8...v1.0.9
[1.0.8]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.7...v1.0.8
[1.0.7]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.6...v1.0.7
[1.0.6]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.5...v1.0.6
[1.0.5]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.4...v1.0.5
[1.0.4]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/no-problem-dev/swift-design-system/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/no-problem-dev/swift-design-system/releases/tag/v1.0.0

<!-- Auto-generated on 2025-11-08T11:54:43Z by release workflow -->

<!-- Auto-generated on 2025-11-09T00:21:22Z by release workflow -->

<!-- Auto-generated on 2025-11-09T08:30:33Z by release workflow -->

<!-- Auto-generated on 2025-11-09T13:28:30Z by release workflow -->

<!-- Auto-generated on 2025-11-16T09:24:46Z by release workflow -->

<!-- Auto-generated on 2025-11-16T22:16:30Z by release workflow -->

<!-- Auto-generated on 2025-11-16T23:22:19Z by release workflow -->

<!-- Auto-generated on 2025-12-21T03:25:36Z by release workflow -->
