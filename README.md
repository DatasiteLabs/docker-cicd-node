# docker-cicd-node

Docker container for CI/CD builds that has:

- JFrog CLI
- Chromium
- Node
- NPM/Yarn
- Support for Cypress/Mongo In-Memory
- JQ
- Python

[![Docker](https://github.com/DatasiteLabs/docker-cicd-node/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/DatasiteLabs/docker-cicd-node/actions/workflows/docker-publish.yml) ![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/DatasiteLabs/docker-cicd-node?sort=semver)

This image was originally based off https://github.com/justinribeiro/dockerfiles/tree/master/chrome-headless of and is now heavily based off of https://github.com/cypress-io/cypress-docker-images.

## Chrome headless

Example build command

```docker
docker build --pull -t merrillcorporation/docker-cicd-node/chrome-headless:1 ./chrome-headless
```

Run the following in your code workspace.

```docker
docker run \
    -d -it --rm -p 3000:3000 \
    -p 49152:49152 \
    -p 4200:4200 \
    -v $(pwd):/home/node/test \
    --name cicd-node-chrome \
    merrillcorporation/docker-cicd-node/chrome-headless:1
```

Execute against container

```docker
docker exec -it cicd-node-chrome bash
```

### Application Requirements

#### e2e with protractor

Add the following to protractor config

```javascript
capabilities: {
    browserName: 'chrome',
    chromeOptions: {
      args: [ "--headless", "--disable-gpu", "--window-size=1024,768", "--no-sandbox" ]
    }
  },
```

Run example code. replace {appName} with your angular app

```bash
cd ~/test
npm run e2e -- --app {appname}
```
