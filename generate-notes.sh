# Initialize the release notes file
echo "# Release Notes" > release-notes.md
echo "## Changes since $PREV" >> release-notes.md

features=()
fixes=()
others=()

# Classify commits
git log --pretty=tformat:"%s" $PREV..$LAST_TAG --no-merges | while read -r commit
do
    if [[ $commit == feat* ]]; then
    features+=("$commit")
    elif [[ $commit == fix* ]]; then
    fixes+=("$commit")
    else
    others+=("$commit")
    fi
done

# Add "Features" section if there are feature commits
if [ ${#features[@]} -gt 0 ]; then
    echo "### Features" >> release-notes.md
    for feat in "${features[@]}"; do
    echo "- $feat" >> release-notes.md
    done
    echo "" >> release-notes.md
fi

# Add "Bug Fixes" section if there are fix commits
if [ ${#fixes[@]} -gt 0 ]; then
    echo "### Bug Fixes" >> release-notes.md
    for fix in "${fixes[@]}"; do
    echo "- $fix" >> release-notes.md
    done
    echo "" >> release-notes.md
fi

# Add "Other Commits" section if there are other commits
if [ ${#others[@]} -gt 0 ]; then
    echo "### Other Commits" >> release-notes.md
    for other in "${others[@]}"; do
    echo "- $other" >> release-notes.md
    done
fi