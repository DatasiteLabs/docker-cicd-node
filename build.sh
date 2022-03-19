#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker_version=$(cat VERSION)
LOCAL_NAME=datasite/test-cicd-node

echo "Building ${LOCAL_NAME}"

docker build --no-cache --pull -t "${LOCAL_NAME}:${docker_version}-chrome" "${__dir}/"chrome-headless