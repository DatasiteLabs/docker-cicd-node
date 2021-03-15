FROM node:12.21-buster-slim
LABEL version="1.1" maintainer="Kayla Altepeter"
ENV CHROME_DRIVER_VERSION 89.0.4389.23

# We need wget to set up the PPA and xvfb to have a virtual screen and unzip to install the Chromedriver
RUN apt-get update && \
    apt-get install -y wget \
    libaio1 \
    gnupg2 \
    xvfb \ 
    unzip \
    ca-certificates \
    netbase \
    vim \
    openssh-client \
    git \
    python3 \
    jq \
    unzip \
    curl

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
RUN apt-get update -y --no-install-recommends
RUN apt-get install -y google-chrome-stable

# Install latest chrome dev package. following example: https://github.com/ebidel/lighthouse-ci/blob/master/builder/Dockerfile
RUN wget https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip -d /usr/local/bin/ \
    && rm chromedriver_linux64.zip \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

# Add jfrog cli
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod 777 /usr/local/bin/jfrog

# install dumb-init
# https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init

USER node
VOLUME /home/node
EXPOSE 3000
EXPOSE 49152
EXPOSE 4200
ENTRYPOINT ["dumb-init", "--"]
CMD ["node"]
