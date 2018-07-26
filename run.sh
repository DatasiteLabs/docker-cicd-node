#!/usr/bin/env bash
set -o errexit
set -o nounset

curDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker_version=$(cat VERSION)

docker build --no-cache --pull -t mrllsvc/docker-cicd-node:"${docker_version}-chrome" ./chrome-headless
docker push mrllsvc/docker-cicd-node:"${docker_version}-chrome"
docker build --no-cache --pull -t mrllsvc/docker-cicd-node:"${docker_version}-phantomjs" ./phantomjs
docker push mrllsvc/docker-cicd-node:"${docker_version}-phantomjs"

docker run \
		-d -it --rm -p 3000:3000 \
		--name docker-cicd-node-chrome \
		mrllsvc/docker-cicd-node:"${docker_version}-chrome"
