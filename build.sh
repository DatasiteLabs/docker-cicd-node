#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PLATFORMS=${1:-linux/amd64,linux/arm64}
DOCKER_REPO=${2:-0.0.0.0:5001}
LOCAL_NAME=${DOCKER_REPO}/datasite/test-cicd-node

echo "Building ${LOCAL_NAME}"

# Google Chrome is not currently supported on ARM64
docker buildx build --builder=container --platform="${PLATFORMS}" --push --pull -t "${LOCAL_NAME}:latest-chrome" "${__dir}/"chrome-headless
docker buildx build --builder=container --platform="${PLATFORMS}" --push -t "${LOCAL_NAME}-consumer:latest-chrome" --build-arg=DOCKER_REPO=${DOCKER_REPO} "${__dir}/test"
