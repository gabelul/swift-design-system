# Fork Sync & Translation Workflow

## Quick Start

```bash
# Check for updates (takes ~10 seconds)
./sync-upstream.sh

# If updates found, analyze what's new
./merge-upstream.sh analyze

# Merge and translate (takes 1-2 hours)
./merge-upstream.sh merge
git push origin main
```

## Workflow Summary

### 1. Check for Updates
Run `./sync-upstream.sh`
- Checks upstream for new commits
- Shows what's new
- Estimates translation needed

### 2. Analyze Changes (Optional)
Run `./merge-upstream.sh analyze`
- See detailed breakdown of changes
- Review Japanese strings
- Decide to proceed

### 3. Merge & Translate
Run `./merge-upstream.sh merge`
- Merges upstream changes
- Resolves conflicts intelligently
- Translates common patterns automatically
- Shows if AI translation is needed

### 4. Review & Commit
```bash
# Review the changes
git status
git diff

# If everything looks good:
git add .
git commit -m "chore: merge upstream with English translations"
git push origin main
```

## What Gets Automated

**Automatic:**
- Fetches upstream
- Detects changes
- Counts Japanese characters
- Translates common patterns:
  - デザインシステム → Design System
  - カタログ → Catalog
  - コンポーネント → Component
  - トークン → Token

**Manual (with script helpers):**
- Reviewing upstream changes
- Complex contextual translations (AI)
- Final verification
- Committing and pushing

## Why This Approach?

**Better than full automation:**
- ✅ I analyze changes before translating
- ✅ I catch breaking changes upstream introduced
- ✅ No complex API integrations needed
- ✅ Faster for occasional updates
- ✅ You stay in control

**Better than pure manual:**
- ✅ Script handles conflict resolution
- � Automatic pattern translation
- � Japanese character counting
- -1-2 hours instead of 3-4 hours

## My Role

I handle the complex stuff:
- Context-aware translation (not simple find-replace)
- Breaking changes detection
- Architecture compatibility verification
- Quality assurance

You handle:
- Running the script
- Reviewing changes
- Final approval before commit

---

**Current Status:** ✅ 100% English for all user-facing code
