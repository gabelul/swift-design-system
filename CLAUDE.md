# Swift Design System - English Fork

## For AI Agents

**If you're generating app code with this library, read `AI_REFERENCE.md` first.** It has every component's API with copy-paste examples. This CLAUDE.md is for maintaining the fork itself.

## Project Overview

This is an **English-localized fork** of [no-problem-dev/swift-design-system](https://github.com/no-problem-dev/swift-design-system), a comprehensive SwiftUI design system library, extended with 15 additional components and DynamicTheme for AI-assisted app generation.

**Original:** Japanese design system with hardcoded Japanese strings
**This fork:** English translation + expanded component library + DynamicTheme

## 🎯 Purpose

To provide English-speaking developers with a fully English Swift design system library they can use directly, without Japanese text obscuring the API documentation, code examples, or UI strings.

## 🔄 Keeping Fork in Sync with Upstream

### Quick Start (3 commands)

```bash
# 1. Check for updates
./sync-upstream.sh

# 2. Analyze what's new
./merge-upstream.sh analyze

# 3. Merge and translate
./merge-upstream.sh merge
git push origin main
```

### Detailed Workflow

**When upstream releases updates:**

1. **Detect:** Run `./sync-upstream.sh` to check for new commits
2. **Analyze:** Run `./merge-upstream.sh analyze` to see what changed
3. **Merge & Translate:** Run `merge-upstream.sh merge` to merge and translate
4. **Review:** Check the diff - verify translations look good
5. **Commit:** `git add . && git commit -m "chore: merge upstream with English translations"`
6. **Push:** `git push origin main`

## 🇯🇵 Translation Process

### What Gets Translated

- ✅ **All catalog views** (UI text, descriptions, code examples)
- ✅ **All component APIs** (documentation, function names, parameters)
- ✅ **All UI strings** (buttons, labels, errors, messages)
- ✅ **Code examples** (example code in catalog views)
- ✅ **Documentation comments** (doc comments, inline comments)

### Translation Approach

**AI-Assisted Translation (Current Method)**

Since Japanese is highly contextual, translation MUST be done by AI (Claude) rather than simple find-replace. This ensures:

- **Context awareness:** "保存しました" = "Saved" (notification), "完了" = "Completed" (task)
- **Technical accuracy:** Swift/SwiftUI concepts properly translated
- **API consistency:** English naming conventions maintained
- **Code examples:** Natural English examples that demonstrate proper usage

### Translation Scripts

**`./sync-upstream.sh`** - Check for updates
- Fetches upstream
- Compares versions
- Shows what's new

**`./merge-upstream.sh`** - Merge and translate
- Merges upstream changes
- Resolves conflicts (catalog vs non-catalog)
- Translates common Japanese patterns automatically
- Shows remaining Japanese that need AI translation
- Guides through the translation process

## 🏗️ Architecture

**This fork maintains structural compatibility with upstream:**
- Same file structure as upstream
- Same component API (only strings changed from Japanese to English)
- Same catalog structure (unified in v1.0.22)
- Same component implementations

**What differs:**
- All strings translated to English
- All documentation in English
- All UI strings in English
- All code examples in English

## 📊 Current Status

**Translation:** ✅ **100% English** — zero Japanese in any Swift source file

**Components:** 25 total (10 upstream + 15 fork additions)
- Upstream: Button, Card, Chip, DSTextField, FAB, IconButton, IconBadge, ProgressBar, Snackbar, StatDisplay, VideoPlayer
- Fork additions: Accordion, Avatar, Badge, BottomSheet, DSSecureField, EmptyState, ErrorState, LoadingState, SearchField, Skeleton, StatusBanner, Toast

**Layout:** 3 patterns — AspectGrid (upstream) + FlowLayout, Screen (fork). `SectionCard` moved to `Components/Section/` in upstream v1.0.24 and is no longer a Layout pattern.

**Section family (v1.0.24):** SectionCard, SectionRow, SectionRowDivider, SectionNavigationLabel

**Themes:** 8 total (7 upstream + DynamicTheme from fork)

**Documentation:** See `FORK_ADDITIONS.md` for complete list of what this fork adds vs upstream

## 🤖️ AI Assistant Role

**Claude (me)** provides assisted translation through:

1. **Context-Aware Translation** - Understands Japanese idioms and technical Swift concepts
2. **Breaking Change Detection** - Identifies upstream changes that could break the fork
3. **Conflict Resolution** - Intelligently resolves merge conflicts preserving translations
4. **Quality Assurance** - Verifies no Japanese remains in critical paths
5. **Automation Scripts** - Helper scripts to speed up the workflow

**Why AI Translation:**
- Japanese requires understanding context (same word = different meaning in different contexts)
- Technical Japanese (Swift, SwiftUI) needs domain knowledge
- New strings from upstream won't exist in translation dictionaries
- AI ensures translations are natural and technically accurate

## 🔧 Tools Used

- **Git** - Version control for syncing with upstream
- **Sed** - Common pattern translation (used by scripts)
- **Claude AI** - Context-aware intelligent translation
- **grep/sed/git diff** - Change detection and verification

## 📚 Documentation

- `sync-upstream.sh` - Update check script
- `merge-upstream.sh` - Merge and translation workflow
- `CLAUDE.md` - This file (project documentation)
- `TRANSLATION_WORKFLOW.md` - Detailed workflow guide

## 📝 Example Session

```bash
# Check for updates
./sync-upstream.sh

# Output: "Changes found! Analyzing what's new..."

# Analyze first
./merge-upstream.sh analyze

# Output: "📊 What's New in Upstream..."
#          "📁 23 files changed"

# If it looks good, merge
./merge-upstream.sh merge

# The script merges and translates, then shows:
# "✅ All translated! Ready to commit"

# Review and commit
git status
git diff
git add .
git commit -m "chore: merge upstream v1.0.23 with English translations"
git push origin main
```

## 🎓 Learning Resources

To understand the design system:

1. Open `DesignSystemCatalog/DesignSystemCatalogApp.swift`
2. Run the catalog app
3. Browse components, tokens, and examples
4. See English translations in action

---

**Last Updated:** January 12, 2026

**Fork URL:** https://github.com/gabelul/swift-design-system

**Upstream:** https://github.com/no-problem-dev/swift-design-system

**Version:** Based on upstream v1.0.24

---

**Maintained by:** gabelul (English localization)

**Original Author:** no-problem-dev
