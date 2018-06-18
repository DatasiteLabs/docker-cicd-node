#!/usr/bin/env bash
curDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker_version=7

docker build --no-cache --pull -t mrllsvc/node-git-ubuntu:"${docker_version}" -t mrllsvc/node-git-ubuntu:latest .
docker push mrllsvc/node-git-ubuntu:"${docker_version}"
docker push mrllsvc/node-git-ubuntu:latest

docker run \
		-d -it --rm -p 3000:3000 \
		--name node-git-ubuntu \
		mrllsvc/node-git-ubuntu:"${docker_version}"
