#!/bin/bash

#docker-compose -f docker/docker-compose.yml up -d
# From here real cicd script test

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

if [ "$BRANCH_NAME" == "dev" ]; then
    IMAGE=<dockerhub-username>/dev:latest
elif [ "$BRANCH_NAME" == "master" ]; then
    IMAGE=<dockerhub-username>/prod:latest
fi

echo "Pulling image..."
docker pull $IMAGE

echo "Stopping old container..."
docker rm -f react-app || true

echo "Running new container..."
docker run -d -p 80:80 --name react-app $IMAGE
