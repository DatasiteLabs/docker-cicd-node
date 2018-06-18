# docker-cicd-npm
Docker container for CICD builds that has openjdk, npm, sonar runner

## Chrome headless
Example build command
```docker
docker build --pull -t mrllsvc/docker-cicd-npm/chrome-headless:1 .
```

Run the following in your code workspace.
```docker
docker run \
    -d -it --rm -p 3000:3000 \
    -p 49152:49152 \
    -p 4200:4200 \
    -v $(pwd):/home/node/test \
    --name cicd-npm-chrome \
    mrllsvc/docker-cicd-npm/chrome-headless:1
```

Execute against container
```docker
docker exec -it cicd-npm-chrome bash
```

Run example code. replace {appName} with your angular app
```bash
cd ~/test
npm run e2e -- --app {appname}
```