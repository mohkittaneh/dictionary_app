#!/bin/bash

docker stop dictionary-app || true
docker rm dictionary-app || true

git pull origin main || { echo "Git pull failed"; exit 1; }

docker build -t dictionary-app . || { echo "Docker build failed"; exit 1; }

docker run -d -p 80:80 --name dictionary-app dictionary-app || { echo "Docker run failed"; exit 1; }

echo "Deployment successful!"
