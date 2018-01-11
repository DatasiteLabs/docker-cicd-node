#!/usr/bin/env bash
docker build -t mrllsvc/node-git-alpine:latest .

docker run \
		-d -it --rm -p 3000:3000 \
		--name node-git-alpine \
		mrllsvc/node-git-alpine:latest