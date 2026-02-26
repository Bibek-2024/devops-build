#!/bin/bash
#docker build -t my-react-app:latest -f docker/Dockerfile .
#From here new updated script for cicd flow test


IMAGE_NAME=my-react-app
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo "Building Docker image..."
docker build -t $IMAGE_NAME:latest .

echo "Tagging image..."

if [ "$BRANCH_NAME" == "dev" ]; then
    docker tag $IMAGE_NAME:latest <dockerhub-username>/dev:latest
elif [ "$BRANCH_NAME" == "master" ]; then
    docker tag $IMAGE_NAME:latest <dockerhub-username>/prod:latest
fi
