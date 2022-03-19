#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

docker_version=$(cat VERSION)
LOCAL_NAME=datasite/test-cicd-node

echo "Running tests against ${LOCAL_NAME}"
docker run -it -v "$(PWD)"/test:/test -w /test "${LOCAL_NAME}:${docker_version}-chrome" bash -c "npm ci; npm run test"
