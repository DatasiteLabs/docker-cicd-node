#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker_version=$(cat VERSION)

docker build --no-cache --pull -t docker-cicd-node:"${docker_version}-chrome" "${__dir}/"chrome-headless
# docker build --no-cache --pull -t mrllsvc/docker-cicd-node:"${docker_version}-chrome" "${__dir}/"chrome-headless
# docker push mrllsvc/docker-cicd-node:"${docker_version}-chrome"
docker build --no-cache --pull -t docker-cicd-node:"${docker_version}-phantomjs" "${__dir}/"phantomjs
# docker build --no-cache --pull -t mrllsvc/docker-cicd-node:"${docker_version}-phantomjs" "${__dir}/"phantomjs
# docker push mrllsvc/docker-cicd-node:"${docker_version}-phantomjs"