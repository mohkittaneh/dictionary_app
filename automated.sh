#!/bin/bash

# Variables
REPO_DIR="/var/www/html/dictionary_app"  # Path to your local Git repository
COMMIT_MESSAGE=${1:-"Automated commit from script"}  # Commit message, default if none provided
BRANCH="main"  # Branch to push to

# Navigate to the repository directory
cd "$REPO_DIR" || { echo "Repository directory not found: $REPO_DIR"; exit 1; }

# Check for changes
if ! git diff-index --quiet HEAD --; then
    echo "Changes detected. Committing and pushing to GitHub..."

    # Stage all changes
    git add .

    # Commit changes
    git commit -m "$COMMIT_MESSAGE"

    # Push to GitHub
    git push origin "$BRANCH"

    echo "Changes pushed to GitHub."
else
    echo "No changes detected. Nothing to push."
fi
