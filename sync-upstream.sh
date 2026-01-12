#!/bin/bash
# sync-upstream.sh - Tool to sync fork with upstream and translate Japanese to English

set -e

echo "🔍 Checking for upstream updates..."

# Fetch upstream
git fetch upstream

# Check if there are changes
if [ "$(git rev-parse main)" = "$(git rev-parse upstream/main)" ]; then
    echo "✅ Already up to date with upstream!"
    exit 0
fi

echo "📊 Changes found! Analyzing what's new..."

# Count changes
CHANGED_FILES=$(git diff --name-only upstream/main..HEAD | grep "\.swift$" | wc -l | tr -d ' ')
echo "📁 $CHANGED_FILES Swift files changed"

# Show summary of changes
echo ""
echo "Summary of changes:"
git diff --stat upstream/main..HEAD | tail -5

echo ""
echo "📋 Files requiring translation:"
git diff --name-only upstream/main..HEAD | grep "\.swift$" | head -10

# Count Japanese characters in changed files
JAPANESE_COUNT=$(git diff upstream/main..HEAD Sources/ --include="*.swift" | grep -o "[一-龥]" | wc -l | tr -d ' ')
echo ""
echo "🇯🇵 Japanese characters in changed files: $JAPANESE_COUNT"
echo ""

if [ $JAPANESE_COUNT -eq 0 ]; then
    echo "✅ No translation needed - just merge!"
    echo ""
    echo "Want to proceed with merge? Run:"
    echo "  ./merge-upstream.sh merge"
else
    echo ""
    echo "Translation required! Run:"
    echo "  ./merge-upstream.sh translate"
    echo ""
    echo "Or analyze changes first:"
    echo "  ./merge-upstream.sh analyze"
fi
