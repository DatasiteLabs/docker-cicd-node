FROM datasite/test-cicd-node:latest-chrome

RUN echo "current user: $(whoami)" && \
    echo "current node: $(node -v)" && \
    echo "current npm:  $(npm -v)"

COPY --chown=node ./ /home/node/test
WORKDIR /home/node/test

ENTRYPOINT [ "bash", "-c", "ls -la; npm ci; npm run test" ]