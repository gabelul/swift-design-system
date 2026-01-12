#!/bin/bash
# merge-upstream.sh - Tool to merge upstream and translate Japanese to English

set -e

COMMAND=${1:-analyze}
COMMIT_HASH=$(git rev-parse HEAD)
MERGE_CONFLICTS=0

show_help() {
    cat << EOF
sync-upstream.sh - Merge upstream and translate Japanese to English

USAGE:
    ./merge-upstream.sh COMMAND [OPTIONS]

COMMANDS:
    analyze        Show what's new in upstream without merging
    merge          Merge upstream changes and translate all Japanese
    translate-only Translate working directory without merging

OPTIONS:
    --dry-run     Show what would be done without executing

EXAMPLES:
    ./mergeupstream.sh analyze
    ./mergeupstream.sh merge
    ./mergeupstream.sh translate-only
EOF
}

check_requirements() {
    if [ ! -d .git ]; then
        echo "❌ Error: Must be run from project root"
        exit 1
    fi

    if ! git rev-parse upstream/main >/dev/null 2>&1; then
        echo "❌ Error: Upstream not configured. Run: git remote add upstream https://github.com/no-problem-dev/swift-design-system.git"
        exit 1
    fi
}

analyze_upstream() {
    echo "🔍 Analyzing upstream changes..."
    git fetch upstream

    if [ "$(git rev-parse main)" = "$(git rev-parse upstream/main)" ]; then
        echo "✅ Already up to date!"
        exit 0
    fi

    echo ""
    echo "📊 What's New in Upstream:"
    echo ""
    git log --oneline upstream/main ^HEAD | head -10
    echo ""

    NEW_FILES=$(git diff --name-only --diff-filter=A upstream/main..HEAD | grep "\.swift$" | wc -l | tr -d ' ')
    MODIFIED_FILES=$(git diff --name-only upstream/main..HEAD --diff-filter=M upstream/main..HEAD | grep "\.swift$" | wc -l | tr -d ' ')

    echo "📁 New files: $NEW_FILES"
    echo "📝 Modified files: $MODIFIED_FILES"

    echo ""
    echo "📝 Files with Japanese:"
    git diff upstream/main..HEAD Sources/ --include="*.swift" | grep -o "[一-龥]" | sort | uniq -c | sort -rn | head -10
    echo ""
    echo "Ready to merge? Run:"
    echo "  ./merge-upstream.sh merge"
}

translate_only() {
    echo "🇯🇵 Translating Japanese in working directory..."
    git diff --name-only upstream/main..HEAD Sources/DesignSystem/Catalog/ --include="*.swift" | while read file; do
        echo "  → $file"
        # Common translations
        sed -i '' 's/デザインシステム/Design System/g; s/カタログ/Catalog/g; s/コンポーネント/Component/g' "$file"

        # Count remaining
        REMAINING=$(grep -o "[一-龥]" "$file" | wc -l | tr -d ' ')
        if [ "$REMAINING" -gt 0 ]; then
            echo "    ⚠️  $REMAINING Japanese chars remain (requires AI translation)"
        else
            echo "    ✅ Fully translated"
        fi
    done
    echo ""
    echo "Translation complete! Review changes then:"
    echo "  git add ."
    echo "  git commit -m 'chore: translate Japanese to English'"
}

merge_upstream() {
    echo "🔄 Merging upstream..."
    git merge upstream/main --no-commit --no-ff 2>&1 | head -30 || echo "Conflicts detected"

    # Handle conflicts - take upstream for non-catalog files
    echo ""
    echo "⚙️  Resolving conflicts..."
    find Sources/DesignSystem/Catalog/ -name "*.swift" -exec git checkout --theirs {} \; 2>/dev/null || echo "Catalog conflicts: manual review needed"

    # Remove conflict markers
    find Sources/ -name "*.swift" -exec sed -i '' '/^<<<<<<< HEAD$/,/^=======$/,/^>>>>>>> upstream\/main$/d' {} \; 2>/dev/null || echo "Conflict markers cleaned"

    echo ""
    echo "🇯🇵 Translating conflicts..."
    # Translate common Japanese patterns in conflict files
    find Sources/DesignSystem/Catalog -name "*.swift" -exec sed -i '' '
        s/デザインシステム/Design System/g
        s/カタログ/Catalog/g
        s/コンポーネント/Component/g
        s/トークン/Token/g
    ' \; 2>/dev/null

    # Count remaining Japanese
    REMAINING=$(grep -ro "[一-龥]" Sources/DesignSystem/Catalog/ --include="*.swift" | wc -l | tr -d ' ')
    echo "    Japanese characters remaining: $REMAINING"

    if [ "$REMAINING" -gt 0 ]; then
        echo ""
        echo "🤖️  AI translation needed for $REMAINING Japanese characters"
        echo "    Run: ./merge-upstream.sh translate-only && ./merge-upstream.sh merge"
    else
        echo ""
        echo "✅ All translated! Ready to commit."
        echo ""
        echo "To commit:"
        echo "  git add ."
        echo "  git commit -m 'chore: merge upstream with English translations'"
    fi
}

# Main logic
case $COMMAND in
    analyze)
        check_requirements
        analyze_upstream
        ;;
    merge)
        check_requirements
        merge_upstream
        ;;
    translate-only)
        translate_only
        ;;
    *)
        show_help
        exit 1
        ;;
esac

exit 0
