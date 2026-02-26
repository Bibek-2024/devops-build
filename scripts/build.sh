#!/bin/bash
set -e

# -----------------------------
# Variables
# -----------------------------
IMAGE_NAME="my-react-app"
DOCKERHUB_USER=${DOCKERHUB_USER:-bibekdec2022}
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD || echo "dev")}
TAG=${BUILD_NUMBER:-latest}  # use Jenkins build number if available

# Determine full image name based on branch
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

# Stop old container if exists
if [ "$(docker ps -q -f name=react-app)" ]; then
    echo "Stopping old container..."
    docker stop react-app
fi

if [ "$(docker ps -aq -f name=react-app)" ]; then
    echo "Removing old container..."
    docker rm react-app
fi

# Pull latest image (optional, since Jenkins already built it)
docker pull $IMAGE || true

# Run new container
echo "Running new container..."
docker run -d \
    --name react-app \
    -p 80:80 \
    $IMAGE

echo "Deployment completed successfully!"
