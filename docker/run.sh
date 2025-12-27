#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME=orangepi-build:jammy
CONTAINER_WORKDIR=/orangepi-build

# docker directory (script location)
DOCKER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOCKERFILE="${DOCKER_DIR}/dockerfile"
MD5_FILE="${DOCKER_DIR}/.dockerfile.md5"

# repository root (must be a git repository)
REPO_ROOT="$(git rev-parse --show-toplevel)"

# calculate current dockerfile md5
CURRENT_MD5="$(md5sum "${DOCKERFILE}" | awk '{print $1}')"

REBUILD=false

if ! docker image inspect "${IMAGE_NAME}" >/dev/null 2>&1; then
    REBUILD=true
elif [[ ! -f "${MD5_FILE}" ]]; then
    REBUILD=true
else
    STORED_MD5="$(cat "${MD5_FILE}")"
    if [[ "${CURRENT_MD5}" != "${STORED_MD5}" ]]; then
        REBUILD=true
    fi
fi

if [[ "${REBUILD}" == "true" ]]; then
    echo "[INFO] Rebuilding Docker image ${IMAGE_NAME}"
    docker build \
        -t "${IMAGE_NAME}" \
        -f "${DOCKERFILE}" \
        "${DOCKER_DIR}"
    echo "${CURRENT_MD5}" > "${MD5_FILE}"
else
    echo "[INFO] Docker image is up to date"
fi

# Takeaways:
# * Runs as root to avoid issues with sudo and privileges
# * Runs in privileged mode for mount to work
# * /dev is passed for loop devices to appear
docker run --rm -it --privileged \
  -v "${REPO_ROOT}:${CONTAINER_WORKDIR}" \
  -w "${CONTAINER_WORKDIR}" \
  -v /dev:/dev \
  "${IMAGE_NAME}" \
  bash -l
