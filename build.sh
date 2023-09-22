#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOCKER_REPO=${1:-0.0.0.0:5001}
LOCAL_NAME=${DOCKER_REPO}/datasite/test-cicd-node

echo "Building ${LOCAL_NAME}"

# Google Chrome is not currently supported on ARM64
docker buildx build --builder=container --platform=linux/amd64,linux/arm64 --push --pull -t "${LOCAL_NAME}:latest-chrome" "${__dir}/"chrome-headless
docker push "${LOCAL_NAME}:latest-chrome"
# docker pull ${LOCAL_NAME}:latest-chrome
docker buildx build --builder=container --platform=linux/amd64,linux/arm64 --push --build-arg=DOCKER_REPO=${DOCKER_REPO} -t test-cicd-node-consumer --build-arg=DOCKER_REPO=${DOCKER_REPO} "${__dir}/test"
