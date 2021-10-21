#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

docker_version=$(cat VERSION)

docker run \
--rm -p 3000:3000 \
-t -d -u 1000:1000 -v "$(pwd)":/home/node/workspace -w /home/node/workspace \
--name docker-cicd-node-chrome \
datasite:"${docker_version}-chrome" cat
