#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LOCAL_NAME=datasite/test-cicd-node

echo "Building ${LOCAL_NAME}"

docker build --no-cache --pull -t "${LOCAL_NAME}:latest-chrome" "${__dir}/"chrome-headless