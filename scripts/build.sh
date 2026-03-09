!/bin/bash
set -e

# --- Configuration ---
DOCKERHUB_USERNAME="bibekdec2022"   # <-- replace with your actual Docker Hub username
IMAGE_NAME="dev"                    # <-- use "dev" since that's the repo you push to
TAG="latest"
REPO="${DOCKERHUB_USERNAME}/${IMAGE_NAME}"
CONTAINER_NAME="react-app"          # keep the container name consistent

# --- Deployment Steps ---

echo "Pulling image ${REPO}:${TAG}..."
docker pull "${REPO}:${TAG}"

echo "Stopping old container ${CONTAINER_NAME}..."
docker stop "${CONTAINER_NAME}" || true
docker rm "${CONTAINER_NAME}" || true

echo "Running new container ${CONTAINER_NAME}..."
docker run -d --name "${CONTAINER_NAME}" -p 80:80 "${REPO}:${TAG}"
