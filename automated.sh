#!/bin/bash

# Variables
BRANCH="main"
REPO_URL="github.com:mohkittaneh/dictionary_app.git"

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "Uncommitted changes detected. Stashing changes..."
    git stash
    STASHED=true
else
    STASHED=false
fi

# Pull the latest changes from the remote repository
echo "Pulling the latest changes from the remote repository..."
if git pull --rebase; then
    echo "Successfully pulled the latest changes."
else
    echo "Rebase failed. Resolving conflicts..."
    git rebase --abort
    git pull --merge
    echo "Merge completed."
fi

# Apply stashed changes if any
if [ "$STASHED" = true ]; then
    echo "Reapplying stashed changes..."
    git stash pop
    if [ $? -ne 0 ]; then
        echo "Conflict detected while applying stashed changes. Resolve conflicts manually."
        exit 1
    fi
fi

# Stage and commit any new changes
if ! git diff-index --quiet HEAD --; then
    echo "Changes detected. Committing and pushing to GitHub..."
    git add .
    git commit -m "Automated commit from script"
fi

# Push changes to the remote repository
echo "Pushing changes to the remote repository..."
if git push; then
    echo "Changes pushed successfully."
else
    echo "Push failed. Attempting to resolve..."
    git pull --rebase
    git push
fi

echo "Script execution completed."

