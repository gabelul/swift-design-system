# Contributing to This Fork

This repository is an **English-localized fork** of  
[`no-problem-dev/swift-design-system`](https://github.com/no-problem-dev/swift-design-system).

The goal of this fork is:

- To provide **English documentation and catalog UI** for the original design system.
- To keep **public APIs, theme IDs, and behavior identical** to upstream.
- To stay **easy to rebase/merge** onto the upstream repository.

Because of that, contributions to this fork should follow a few guidelines.

---

## Scope of Changes

Allowed (and encouraged):

- Translating documentation comments (`///`) from Japanese to English.
- Translating user-facing strings in:
  - Catalog views (`Sources/DesignSystem/Catalog/...`)
  - Alerts, dialog titles, labels, and messages.
- Adding English documentation such as `README_en.md` or additional guides.

Avoid:

- Renaming public types, functions, protocols, or modifiers.
  - Examples: `ThemeProvider`, `ThemeMode`, `SectionCard`, `ButtonSize`, `ColorPalette`.
- Changing theme IDs or other programmatic identifiers.
  - Examples: `"default"`, `"ocean"`, `"forest"`, `"sunset"`, `"purpleHaze"`,
    `"monochrome"`, `"highContrast"`.
- Making behavioral changes that diverge from upstream without a strong reason.

If you need new functionality, prefer adding it in your **app code** rather than
changing the core library in this fork.

---

## Keeping in Sync with Upstream

This fork assumes the original repo as the source of truth.

Typical workflow:

```bash
git remote add upstream https://github.com/no-problem-dev/swift-design-system.git

# Update from upstream
git fetch upstream
git checkout main
git merge upstream/main            # or: git rebase upstream/main
```

After syncing `main`, update your translation branch:

```bash
git checkout translation           # or your feature branch
git rebase main                    # or merge main
```

Resolve any conflicts (usually docs/strings), run the catalog app, and push.

---

## Where to Put English Docs

- High-level English overview: `README_en.md`.
- Detailed English docs:
  - API and usage: DocC-style comments in `Sources/DesignSystem/...`.
  - Catalog/demo explanations: `Sources/DesignSystem/Catalog/...`.

Please **do not replace** the original Japanese `README.md` or DocC authoring
in this fork; instead, add English alongside it (separate files or translated
comments).

---

## Submitting Changes

When opening a PR against this fork:

- Keep changes focused on **translations and documentation**.
- Clearly mention if any runtime behavior or public surface changed.
- If you synced from upstream, note the upstream commit/Tag you rebased on.

This helps keep the fork clean, easy to maintain, and easy to re-sync with
the original project. 

