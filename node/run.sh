#!/usr/bin/env bash
curDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[[ $1 ]] || { echo "missing an argument. first argument must be jfrog email" >&2; exit 1; }
[[ $2 ]] || { echo "missing an argument. first argument must be jfrog token for user with email: ${1}" >&2; exit 1; }
jfrog_email="${1}"
jfrog_password="${2}"

docker_version=5

${curDir}/inject-npmrc.sh ${jfrog_email} ${jfrog_password}

docker build --no-cache --pull -t mrllsvc/node-git-ubuntu:"${docker_version}" -t mrllsvc/node-git-ubuntu:latest .
docker push mrllsvc/node-git-ubuntu:"${docker_version}"
docker push mrllsvc/node-git-ubuntu:latest

docker run \
		-d -it --rm -p 3000:3000 \
		--name node-git-ubuntu \
		mrllsvc/node-git-ubuntu:"${docker_version}"