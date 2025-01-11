#!/bin/bash

# Step 1: Pull the latest changes from the GitHub repository
echo "Pulling latest code from GitHub..."
git pull origin main

# Step 2: Build and run the Docker container
echo "Building Docker image..."
docker build -t dictionary_app .

echo "Stopping existing container (if any)..."
docker stop dictionary_app 2>/dev/null || true
docker rm dictionary_app 2>/dev/null || true

echo "Running Docker container..."
docker run -d -p 9090:80 --name dictionary-app dictionary-app

# Step 3: Trigger the Jenkins job
echo "Triggering Jenkins job..."
curl -X POST http://<jenkins-server-ip>:9090/job/<dictionary_app>/build --user <mohkittaneh>:<113b5d5cb4c318ae640a69ebca894d8aa0>

echo "Deployment completed successfully!"
