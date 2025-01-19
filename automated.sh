#!/bin/bash

BRANCH="main"
REPO_URL="github.com:mohkittaneh/dictionary_app.git"

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "Uncommitted changes detected. Committing changes..."
    git add .
    git commit -m "Automated commit from script"
else
    echo "No uncommitted changes detected."
fi

# Pull the latest changes from the remote repository
echo "Pulling the latest changes from the remote repository..."
if git pull --rebase; then
    echo "Successfully pulled the latest changes."
else
    echo "Rebase failed. Aborting and merging..."
    git rebase --abort
    git pull --merge
fi

# Push changes to the remote repository
echo "Pushing changes to the remote repository..."
if git push; then
    echo "Changes pushed successfully."
else
    echo "Push failed. Attempting to resolve conflicts..."
    git pull --rebase
    git push
fi

echo "Automatic push completed successfully."
