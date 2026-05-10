# Prototype Translation

Use HTML prototypes as visual references, not literal implementation specs.

## The rule

When you receive an HTML prototype, preserve:
- hierarchy
- density
- grouping
- mood
- brand feel

Adapt for native mobile:
- page rhythm
- touch targets
- title treatment
- scroll structure
- CTA placement
- safe area behavior

## Recommended conversion order

1. Identify the screen type.
   - onboarding
   - dashboard/feed
   - form/action
   - content/detail
2. Choose the page density.
   - `compact`
   - `standard`
   - `spacious`
3. Install brand setup at the root.
   - `ThemeProvider`
   - `TypographyProvider`
   - optional `BrandRecipe`
4. Rebuild with semantic DesignSystem primitives.
   - `Screen`
   - `SectionCard`
   - `Card`
   - `AspectGrid`
   - `FlowLayout`
5. Tune spacing only after typography and density are in the right ballpark.

## Avoid these mistakes

- Don’t copy web spacing literally.
- Don’t pick `display*` just because the HTML’s biggest text is visually dominant.
- Don’t recreate navigation chrome that `Screen` already owns.
- Don’t add a second vertical `ScrollView` inside `Screen` unless a separate scrolling region is truly required.
- Don’t invent app-local typography wrappers if `TypographyProvider` already solves the font-family problem.
