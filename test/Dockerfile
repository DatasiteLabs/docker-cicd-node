ARG DOCKER_REPO
FROM ${DOCKER_REPO}/datasite/test-cicd-node:latest-chrome
RUN echo "current user: $(whoami)" && \
    echo "current node: $(node -v)" && \
    echo "current npm:  $(npm -v)"

COPY --chown=node ./ /home/node/test
WORKDIR /home/node/test

ENTRYPOINT [ "bash", "-c", "ls -la; npm ci; Xvfb :99 & export DISPLAY=:99; npm run test; pkill Xvfb" ]
