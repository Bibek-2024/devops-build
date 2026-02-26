#!/bin/bash
set -e

DOCKERHUB_USER=${DOCKERHUB_USER:-bibekdec2022}
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD || echo "dev")}
TAG="latest"

case "$BRANCH_NAME" in
    dev)
        IMAGE="$DOCKERHUB_USER/dev:$TAG"
        ;;
    main|master)
        IMAGE="$DOCKERHUB_USER/prod:$TAG"
        ;;
    *)
        echo "Branch '$BRANCH_NAME' does not match dev/main, skipping deploy"
        exit 0
        ;;
esac

echo "Deploying Docker image: $IMAGE"

# Stop/remove old container safely
docker stop react-app || true
docker rm react-app || true

echo "Pulling image..."
docker pull $IMAGE || true

echo "Running new container..."
docker run -d --name react-app -p 80:80 $IMAGE
