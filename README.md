# docker-cicd-npm
Docker container for CICD builds that has openjdk, npm, sonar runner


[![Docker Build Status](https://img.shields.io/docker/build/merrillcorporation/docker-cicd-node.svg?style=for-the-badge)](https://hub.docker.com/r/merrillcorporation/docker-cicd-node/builds/)


## PhantomJS
Example build command
```docker
docker build --pull -t merrillcorporation/docker-cicd-node/phantomjs:1 ./phantomjs
```

Run the following in your code workspace.
```docker
docker run \
    -d -it --rm -p 3000:3000 \
    -v $(pwd):/home/node/test \
    --name cicd-node-phantomjs \
    merrillcorporation/docker-cicd-node/phantomjs:1
```

Execute against container
```docker
docker exec -it cicd-node-phantomjs bash
```

### Application Requirements
#### unit testing with karma/jasmine or mocha
Run example code. replace {appName} with your angular app
```bash
cd ~/test
npm test
```

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
add the following to protractor config
```
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
