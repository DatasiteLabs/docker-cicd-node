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

## The test app

This app uses a couple of generated tests to excercise the dependencies.

### Updating Cypress

- [ ] Update `package.json` engines if changing.
- [ ] Update any Dockerfile depenencies that can be updated

```bash
rm -rf test/cypress
npm rm --save-dev cypress
npm i --save-dev cypress
npx cypress open
```

After opening the Cypress app it will prompt you with options.

- [ ] If there is a config migration, execute that.
- [ ] Generate example tests

### Mongo test app

See [README](./test/mongo/README.md) for the mongo test suite on base tests

## Local Testing

To use the build scripts, use docker buildx with multiplatform.

Create a builder

```bash
docker buildx create \
  --name container \
  --driver=docker-container
```

Setup a local registry

```bash
./local_registry.sh
```

Run the scripts

The localdomain can't be localhost, 0.0.0.0, 127.0.0.1 or others on the insecure repository list, port is 5001.

Use: 'host.docker.internal'

Run docker info to see list.

```bash
# ./build.sh <platforms> <localdomain:port>
./build.sh linux/arm64 host.docker.internal:5001 # to pass in a local domain, edit hostsfile
```
