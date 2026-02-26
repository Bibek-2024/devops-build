#!/bin/bash
set -e

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

DOCKERHUB_USERNAME="bibekdec2022"

if [ "$BRANCH_NAME" == "dev" ]; then
    IMAGE="bibekdec2022/dev:latest"
elif [ "$BRANCH_NAME" == "master" ]; then
    IMAGE="bibekdec2022/prod:latest"
else
    echo "Unknown branch: $BRANCH_NAME"
    exit 1
fi

echo "Pulling image..."
docker pull "$IMAGE"

echo "Stopping old container..."
docker rm -f react-app || true

echo "Running new container..."
docker run -d -p 80:80 --name react-app "$IMAGE"
