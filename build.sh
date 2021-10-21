#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker_version=$(cat VERSION)

docker build --no-cache --pull -t datasite:"${docker_version}-chrome" -t datasite:latest-chrome "${__dir}/"chrome-headless