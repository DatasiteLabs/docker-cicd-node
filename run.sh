#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

DOCKER_REPO=0.0.0.0:5001
LOCAL_NAME=${DOCKER_REPO}/datasite/test-cicd-node
echo "Running ${LOCAL_NAME}"

# docker run \
# --rm -it -p 3000:3000 \
# -u 1000:1000 -v "$(pwd)":/home/node/workspace -w /home/node/workspace \
# --name docker-cicd-node-local \
# datasite/test-cicd-node bash

# docker run -it -v "${__dir}/test:/home/node/test" -w /home/node/test --user node "${LOCAL_NAME}:latest-chrome" bash
docker run -it -p 3000:3000 --user node  "${LOCAL_NAME}:latest-chrome" bash
