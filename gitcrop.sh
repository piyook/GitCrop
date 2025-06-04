#!/usr/bin/env bash

# Verify the main branch name
DEFAULT_BRANCH="main"
if ! git rev-parse --verify "refs/heads/$DEFAULT_BRANCH" >/dev/null 2>&1; then
    DEFAULT_BRANCH="master"  # Fallback to 'master' if 'main' doesn't exist
fi

# Define branches to exclude from deletion
EXCEPTIONS="$DEFAULT_BRANCH|develop"

# Initialize variables
MERGED=false
PATTERN=""

# Parse arguments dynamically (allowing --merged first or last)
for arg in "$@"; do
    if [ "$arg" == "--merged" ] || [ "$arg" == "-m" ]; then
        MERGED=true
    elif [[ "$arg" == "--help" || "$arg" == "-h" ]]; then
        echo ""
        echo "Usage: gitcrop [--merged | -m] <pattern>"
        echo ""
        echo "Use --merged or -m to delete only branches that are fully merged into the main branch."
        echo "Branches matching the pattern will be deleted, excluding: $EXCEPTIONS"
        echo ""
        echo "Example: gitcrop --merged 'feature/*' or gitcrop 'bugfix/*'"
        exit 0
    else
        PATTERN="$arg"
    fi
done

# Ensure a pattern is provided
if [ -z "$PATTERN" ]; then
    echo ""
    echo "Usage: gitcrop [--merged | -m] <pattern>"
    echo ""
    echo "Use --merged or -m to delete only branches that are fully merged into the main branch."
    echo "Branches matching the pattern will be deleted, excluding: $EXCEPTIONS"
    echo ""
    echo "Example: gitcrop --merged 'feature/*' or gitcrop 'bugfix/*'"
    exit 1
fi

# Get the list of merged branches matching the pattern, excluding exceptions
if [ "$MERGED" = true ]; then
    LOCAL_BRANCHES=$(git branch --merged "$DEFAULT_BRANCH" | grep -E "$PATTERN" | grep -Ev "$EXCEPTIONS")
else
    LOCAL_BRANCHES=$(git branch | grep -E "$PATTERN" | grep -Ev "$EXCEPTIONS")
fi

# Check if any branches match the pattern
if [ -z "$LOCAL_BRANCHES" ]; then
    if [ "$MERGED" = true ]; then
        echo "No local branches found matching pattern: $PATTERN that were also merged into '$DEFAULT_BRANCH' (excluding $EXCEPTIONS branches)"
    else
        echo "No local branches found matching pattern: $PATTERN (excluding $EXCEPTIONS branches)"
    fi
    exit 0
fi

# Display appropriate confirmation message
echo "The following local branches will be deleted:"
echo "$LOCAL_BRANCHES"

if [ "$MERGED" = true ]; then
    echo "(These branches were fully merged into '$DEFAULT_BRANCH'.)"
fi

read -p "Are you sure? (y/n) " CONFIRM

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "$LOCAL_BRANCHES" | xargs git branch -D
    echo "Local branches deleted."
else
    echo "Deletion cancelled."
fi