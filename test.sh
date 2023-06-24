#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOCKER_REPO=0.0.0.0:5001
LOCAL_NAME=${DOCKER_REPO}/datasite/test-cicd-node

echo "Running tests against ${LOCAL_NAME}"
docker run -it --user node test-cicd-node-consumer:latest
# docker run --rm -v "${__dir}/test:/home/node/test:rw" -w /home/node/test --user root "${LOCAL_NAME}:latest-chrome" bash -c "export CYPRESS_CACHE_FOLDER=/home/node/test/.cache; npm ci; npm run test" # testing git action issues
