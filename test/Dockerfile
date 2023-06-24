ARG DOCKER_REPO
FROM ${DOCKER_REPO}/datasite/test-cicd-node:latest-chrome
RUN echo "current user: $(whoami)" && \
    echo "current node: $(node -v)" && \
    echo "current npm:  $(npm -v)"

COPY --chown=node ./ /home/node/test
WORKDIR /home/node/test

USER node
RUN npm ci

ENTRYPOINT [ "bash", "-c", "./execute-test.sh" ]
