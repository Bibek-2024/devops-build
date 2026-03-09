#!/bin/bash
set -e

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

if [ "$BRANCH_NAME" == "dev" ]; then
    IMAGE="bibekdec2022/dev:latest"
elif [ "$BRANCH_NAME" == "master" ]; then
    IMAGE="bibekdec2022/prod:latest"
else
    echo "Branch not supported"
    exit 1
fi

echo "Pulling image $IMAGE"

docker pull $IMAGE

docker stop react-app || true
docker rm react-app || true

docker run -d -p 80:80 --name react-app $IMAGE
