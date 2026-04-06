# DesignSystem AI Reference

Quick reference for AI agents generating SwiftUI code with this design system.
Import with `import DesignSystem`. All components use design tokens from `@Environment`.

---

## Setup (2 lines)

```swift
// In your App struct
@State var themeProvider = ThemeProvider(
    initialTheme: DynamicTheme(brandColor: Color(hex: "#6366F1"))
)

// Wrap your root view
ContentView().theme(themeProvider)
```

Change the hex color to rebrand the entire app. That's it.

---

## Tokens (always use these, never hardcode values)

```swift
@Environment(\.colorPalette) var colors   // colors.primary, .onSurface, .error, etc.
@Environment(\.spacingScale) var spacing   // spacing.sm(8), .md(12), .lg(16), .xl(24)
@Environment(\.radiusScale) var radius     // radius.sm(4), .md(8), .lg(12), .full(9999)
@Environment(\.motion) var motion          // motion.tap, .toggle, .spring, .slide
```

### Color Roles
- `colors.primary` / `.onPrimary` — brand actions, links
- `colors.surface` / `.onSurface` — card backgrounds, body text
- `colors.background` / `.onBackground` — screen background
- `colors.error` / `.success` / `.warning` / `.info` — semantic states
- `colors.outline` — borders, dividers

### Typography (modifier, not Font)
```swift
Text("Heading").typography(.headlineLarge)
Text("Body").typography(.bodyMedium)
Text("Label").typography(.labelSmall)
// Sizes: display(L/M/S), headline(L/M/S), title(L/M/S), body(L/M/S), label(L/M/S)
```

---

## Components Quick Reference

### Screen (page wrapper — use for every screen)
```swift
Screen("Page Title") {
    // content gets ScrollView + padding + background automatically
}
```

### Buttons
```swift
Button("Save") { save() }
    .buttonStyle(.primary)    // or .secondary, .tertiary
    .buttonSize(.large)       // or .medium, .small
```

### Card
```swift
Card {
    VStack { Text("Title"); Text("Body") }
}
Card(elevation: .level3, allSides: 24) { content }
```

### DSTextField
```swift
DSTextField("Email", text: $email, placeholder: "you@example.com", leadingIcon: "envelope")
DSTextField("Bio", text: $bio, axis: .vertical)  // multiline
```

### DSSecureField
```swift
DSSecureField("Password", text: $password, placeholder: "Enter password", leadingIcon: "lock")
// Has built-in reveal/hide toggle
```

### SearchField
```swift
SearchField(text: $query, placeholder: "Search items...", onSubmit: { search() })
```

### Chip
```swift
Chip("Tag")                                      // display only
Chip("Filter", isSelected: $isOn)                // toggle
Chip("Action", action: { doSomething() })        // tappable
Chip("Remove", onDelete: { remove() })           // deletable
// Styles: .chipStyle(.filled) / .chipStyle(.outlined)
```

### Avatar
```swift
Avatar(initials: "JD", size: .large)
Avatar(image: Image("photo"), size: .medium)
// Sizes: .small(32), .medium(48), .large(64), .extraLarge(80)
```

### Badge
```swift
Image(systemName: "bell").badge()        // dot
Image(systemName: "cart").badge(3)       // count
Avatar(initials: "AB").badge(5)          // on anything
```

### Accordion
```swift
Accordion("Advanced Settings") {
    Toggle("Debug Mode", isOn: $debug)
}
```

### StatusBanner
```swift
StatusBanner("Saved", level: .success)
StatusBanner("Offline", level: .error, icon: "wifi.slash", actionLabel: "Retry") { reconnect() }
// Levels: .info, .success, .warning, .error
```

### Toast (auto-dismissing notification)
```swift
@State var toast = ToastState()

// Trigger
toast.show(message: "Saved", level: .success)

// In view body
.overlay(alignment: .top) { Toast(state: toast) }
```

### Snackbar (notification with actions)
```swift
@State var snackbar = SnackbarState()

snackbar.show(message: "Deleted", primaryAction: SnackbarAction(title: "Undo") { undo() })

// In view body
Snackbar(state: snackbar)
```

### BottomSheet
```swift
.bottomSheet(isPresented: $showSheet, detent: .medium) {
    Text("Sheet content")
}
// Detents: .small(25%), .medium(50%), .large(85%)
```

### Skeleton (loading placeholder)
```swift
Skeleton().frame(height: 16)                    // text line
Skeleton(.circle).frame(width: 48, height: 48)  // avatar
Skeleton(.roundedRectangle(cornerRadius: 12)).frame(height: 200)  // card

// Or shimmer any view
myView.shimmer(isActive: isLoading)
```

### State Views
```swift
// Empty list
EmptyState(icon: "tray", title: "No Items", message: "Add something") {
    Button("Add Item") { }.buttonStyle(.primary)
}

// Error with retry
ErrorState(title: "Can't load", message: "Check connection", onRetry: { reload() })

// Loading spinner
LoadingState(message: "Loading...")
```

### ProgressBar
```swift
ProgressBar(value: 0.65)
ProgressBar(value: progress, animated: true)
```

### FloatingActionButton
```swift
FloatingActionButton(icon: "plus", size: .regular) { addItem() }
```

### IconButton
```swift
IconButton(icon: "heart.fill", style: .filled, size: .medium) { toggleFavorite() }
// Styles: .standard, .filled, .tonal, .outlined
```

### SectionCard
```swift
SectionCard(title: "Account") {
    Text("Settings go here")
}
```

### FlowLayout (wrapping tags)
```swift
FlowLayout(spacing: 8) {
    ForEach(tags, id: \.self) { Chip($0) }
}
```

### AspectGrid
```swift
AspectGrid(minItemWidth: 160, maxItemWidth: 200, itemAspectRatio: 2/3) {
    ForEach(items) { item in CardView(item: item) }
}
```

---

## Layout Pattern for a Typical Screen

```swift
struct ItemListScreen: View {
    @Environment(\.colorPalette) var colors
    @Environment(\.spacingScale) var spacing
    @State var toast = ToastState()
    @State var items: [Item] = []
    @State var isLoading = true
    @State var error: Error?

    var body: some View {
        Screen("Items") {
            if isLoading {
                LoadingState(message: "Loading items...")
            } else if let error {
                ErrorState(message: error.localizedDescription, onRetry: { load() })
            } else if items.isEmpty {
                EmptyState(icon: "tray", title: "No items yet") {
                    Button("Add Item") { add() }.buttonStyle(.primary)
                }
            } else {
                VStack(spacing: spacing.md) {
                    ForEach(items) { item in
                        Card { Text(item.name) }
                    }
                }
            }
        }
        .overlay(alignment: .top) { Toast(state: toast) }
    }
}
```

---

## Theme Setup Options

```swift
// Option 1: One-color brand (recommended for AI generation)
ThemeProvider(initialTheme: DynamicTheme(brandColor: Color(hex: "#6366F1")))

// Option 2: Built-in theme
ThemeProvider()  // Default blue
ThemeProvider(initialTheme: OceanTheme())

// Option 3: Custom theme (implement Theme protocol)
ThemeProvider(initialTheme: MyCustomTheme())

// Switch at runtime
themeProvider.applyTheme(DynamicTheme(brandColor: .orange))
themeProvider.toggleMode()  // system → light → dark → system
```

---

## Rules for AI Code Generation

1. **Always use tokens** — never `Color.blue`, `.font(.system(size: 16))`, or `.padding(16)`
2. **Always wrap screens in `Screen`** — handles scroll, padding, background
3. **Use state views** — `LoadingState`, `ErrorState`, `EmptyState` for every async screen
4. **Use `DynamicTheme`** — one color = full brand, no palette boilerplate
5. **Prefer `.primary` button style** for main actions, `.secondary` for alternatives
6. **Use `Toast` for confirmations**, `Snackbar` for actions with undo
7. **Use `Skeleton` for loading**, not custom shimmer implementations
8. **Use `StatusBanner` for inline alerts**, not custom colored HStacks
