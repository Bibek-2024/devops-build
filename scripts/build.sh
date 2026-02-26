#!/bin/bash
set -e

# -----------------------------
# Variables
# -----------------------------
IMAGE_NAME="my-react-app"
DOCKERHUB_USER="bibekdec2022"   # your Docker Hub username
DOCKERFILE_PATH="docker/Dockerfile"

# Detect branch: prefer BRANCH_NAME from Jenkins, fallback to git
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD || echo "dev")}

echo "Current branch: $BRANCH_NAME"

# -----------------------------
# Build Docker image
# -----------------------------
echo "Building Docker image..."
docker build -t $IMAGE_NAME:latest -f $DOCKERFILE_PATH .

# -----------------------------
# Tag Docker image
# -----------------------------
echo "Tagging Docker image..."
case "$BRANCH_NAME" in
    dev)
        docker tag $IMAGE_NAME:latest $DOCKERHUB_USER/dev:latest
        docker tag $IMAGE_NAME:latest $DOCKERHUB_USER/dev:${BUILD_NUMBER:-latest}
        ;;
    main|master)
        docker tag $IMAGE_NAME:latest $DOCKERHUB_USER/prod:latest
        docker tag $IMAGE_NAME:latest $DOCKERHUB_USER/prod:${BUILD_NUMBER:-latest}
        ;;
    *)
        echo "Branch '$BRANCH_NAME' does not match dev/main, skipping DockerHub tagging."
        ;;
esac

echo "Docker build and tagging completed successfully!"
