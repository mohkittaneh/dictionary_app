#!/bin/bash

BRANCH="main"
REPO_URL="github.com:mohkittaneh/dictionary_app.git"
JENKINS_URL="http://172.20.10.2:8080/job/dictionary_app2/build"
JENKINS_USER="admin"
JENKINS_TOKEN="11e16ea07662cc8a0a80a3e667c31846fe"

if ! git diff-index --quiet HEAD --; then
    echo "Uncommitted changes detected. Stashing changes..."
    git stash
    STASHED=true
else
    STASHED=false
fi

echo "Pulling the latest changes from the remote repository..."
if git pull --rebase; then
    echo "Successfully pulled the latest changes."
else
    echo "Rebase failed. Resolving conflicts..."
    git rebase --abort
    git pull --merge
    echo "Merge completed."
fi

if [ "$STASHED" = true ]; then
    echo "Reapplying stashed changes..."
    git stash pop
    if [ $? -ne 0 ]; then
        echo "Conflict detected while applying stashed changes. Resolve conflicts manually."
        exit 1
    fi
fi

if ! git diff-index --quiet HEAD --; then
    echo "Changes detected. Committing and pushing to GitHub..."
    git add .
    git commit -m "Automated commit from script"
fi

echo "Pushing changes to the remote repository..."
if git push; then
    echo "Changes pushed successfully."
else
    echo "Push failed. Attempting to resolve..."
    git pull --rebase
    git push
fi

echo "Triggering the Jenkins job..."
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$JENKINS_URL" \
    --user "$JENKINS_USER:$JENKINS_TOKEN")

if [ "$response" -eq 201 ]; then
    echo "Jenkins job triggered successfully!"
elflfe
    echo "Failed to trigger Jenkins job. HTTP Status: $response"
fi

echo "Script execution completed."

