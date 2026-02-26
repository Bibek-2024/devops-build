#!/bin/bash
set -e

# -----------------------------
# Variables
# -----------------------------
IMAGE_NAME="my-react-app"
DOCKERHUB_USER=${DOCKERHUB_USER:-bibekdec2022}
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD || echo "dev")}
TAG_LATEST="latest"

# Determine image based on branch
case "$BRANCH_NAME" in
    dev)
        IMAGE="$DOCKERHUB_USER/dev:$TAG_LATEST"
        ;;
    main|master)
        IMAGE="$DOCKERHUB_USER/prod:$TAG_LATEST"
        ;;
    *)
        echo "Branch '$BRANCH_NAME' does not match dev/main, skipping deploy."
        exit 0
        ;;
esac

echo "Deploying Docker image: $IMAGE"

# Stop old container if exists
if [ "$(docker ps -q -f name=react-app)" ]; then
    echo "Stopping old container..."
    docker stop react-app
fi

# Remove old container if exists
if [ "$(docker ps -aq -f name=react-app)" ]; then
    echo "Removing old container..."
    docker rm react-app
fi

# Pull latest image from Docker Hub (optional, can skip if image built locally)
docker pull $IMAGE || true

# Run new container
echo "Running new container..."
docker run -d \
    --name react-app \
    -p 80:80 \
    $IMAGE

echo "Deployment completed successfully!"
