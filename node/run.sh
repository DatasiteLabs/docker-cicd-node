#!/usr/bin/env bash
#docker build --no-cache --squash --pull -t mrllsvc/node-git-ubuntu:3 mrllsvc/node-git-ubuntu:latest .

docker run \
		-d -it --rm -p 3000:3000 \
		--name node-git-ubuntu \
		mrllsvc/node-git-ubuntu:latest
#
#docker push mrllsvc/node-git-ubuntu:3
#docker push mrllsvc/node-git-ubuntu:latest