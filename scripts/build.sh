#!/bin/bash
set -e

# -----------------------------
# Variables
# -----------------------------
# Use Jenkins environment variables if available
DOCKERHUB_USER=${DOCKERHUB_USER:-bibekdec2022}    # fallback if Jenkins env missing
IMAGE_NAME="my-react-app"
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD || echo "dev")}
TAG="latest"

# Decide which image to deploy based on branch
case "$BRANCH_NAME" in
    dev)
        IMAGE="$DOCKERHUB_USER/dev:$TAG"
        ;;
    main|master)
        IMAGE="$DOCKERHUB_USER/prod:$TAG"
        ;;
    *)
        echo "Branch '$BRANCH_NAME' does not match dev/main, skipping deploy."
        exit 0
        ;;
esac

echo "Deploying Docker image: $IMAGE"

# Stop old container if it exists
if docker ps -q -f name=react-app >/dev/null 2>&1; then
    echo "Stopping old container..."
    docker stop react-app
fi

# Remove old container if it exists
if docker ps -aq -f name=react-app >/dev/null 2>&1; then
    echo "Removing old container..."
    docker rm react-app
fi

# Pull the latest image (optional, safe even if already built locally)
echo "Pulling image..."
docker pull $IMAGE || echo "Image not found locally, using local build"

# Run new container
echo "Running new container..."
docker run -d \
    --name react-app \
    -p 80:80 \
    $IMAGE

echo "Deployment completed successfully!"
