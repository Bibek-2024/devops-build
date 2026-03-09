#!/bin/bash
set -e

IMAGE_NAME="my-react-app"

echo "Building Docker image..."

docker build -t $IMAGE_NAME -f docker/Dockerfile .

echo "Docker image built successfully"
