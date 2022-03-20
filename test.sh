#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LOCAL_NAME=datasite/test-cicd-node

echo "Running tests against ${LOCAL_NAME}"
docker run --rm -v "${__dir}/test:/home/node/test:rw" -w /home/node/test "${LOCAL_NAME}:latest-chrome" bash -c "npm ci; npm run test"
