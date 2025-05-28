#!/bin/bash

# Ensure a pattern is provided
if [ -z "$1" ]; then
    echo "Usage: gitcrop <pattern>"
    echo "This script deletes all local branches matching the specified pattern."
    echo "Example: gitcrop feature/"
    exit 1
fi

PATTERN="$1"
EXCEPTIONS="main|develop"  # Add other branches to exclude as needed

# Get a list of branches matching the pattern, excluding 'main' and 'develop'. 
BRANCHES=$(git branch | grep -E "$PATTERN" | grep -v -E "$EXCEPTIONS")

# Check if any branches match the pattern
if [ -z "$BRANCHES" ]; then
    echo "No branches found matching pattern: $PATTERN"
    exit 0
fi

# Confirm deletion
echo "WARNING: The following branches will be PERMANENTLY deleted:"
echo "$BRANCHES"
read -p "Are you sure? (y/n) " CONFIRM

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "$BRANCHES" | xargs git branch -D
    echo "Branches deleted."
else
    echo "Deletion cancelled."
fi