FROM node:16.15.1-bullseye-slim
LABEL version="1.2" maintainer="Kayla Altepeter"
ENV CHROME_DRIVER_VERSION 99.0.4844.51
ENV CHROMEDRIVER_DIR /chromedriver
# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

# We need wget to set up the PPA and xvfb to have a virtual screen and unzip to install the Chromedriver
RUN apt-get update && \
    apt-get install --no-install-recommends -y wget \
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
    curl \
    libcurl4 \
    # cypress deps: https://github.com/cypress-io/cypress-docker-images/blob/master/base/14.17.0/Dockerfile
    libgtk2.0-0 \
    libgtk-3-0 \
    libnotify-dev \
    libgconf-2-4 \
    libgbm-dev \
    libnss3 \
    libnss3-tools \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    xvfb \
    # install emoji font
    fonts-noto-color-emoji \
    # install Chinese fonts
    # this list was copied from https://github.com/jim3ma/docker-leanote
    fonts-arphic-bkai00mp \
    fonts-arphic-bsmi00lp \
    fonts-arphic-gbsn00lp \
    fonts-arphic-gkai00mp \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    ttf-wqy-zenhei \
    ttf-wqy-microhei \
    xfonts-wqy \
    # clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Local certs
RUN curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64" && \
  chmod +x mkcert-v*-linux-amd64 && \
  mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert

RUN mkcert -install && \
    mkcert example.com "*.example.com" example.test localhost 127.0.0.1 ::1 && \
    mkdir -p /home/node/certs && \
    mv *.pem /home/node/certs/ && \
    chown -R node:node /home/node/certs

# a few environment variables to make NPM installs easier
# good colors for most applications
ENV TERM xterm
# avoid million NPM install messages
ENV npm_config_loglevel warn
# allow installing when the main user is root
ENV npm_config_unsafe_perm true

# Node libraries
RUN node -p process.versions

# Show where Node loads required modules from
RUN node -p 'module.paths'

# versions of local tools
RUN echo  " node version:    $(node -v) \n" \
    "npm version:     $(npm -v) \n" \
    "yarn version:    $(yarn -v) \n" \
    "debian version:  $(cat /etc/debian_version) \n" \
    "user:            $(whoami) \n"

# Chrome dependencies
RUN apt-get update
RUN apt-get install -y \
    fonts-liberation \
    libcurl4 \
    libcurl3-gnutls \
    libcurl3-nss \
    xdg-utils \
    wget \
    # clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# install libappindicator3-1 - not included with Debian 11
RUN wget --no-verbose /usr/src/libappindicator3-1_0.4.92-7_amd64.deb "http://ftp.us.debian.org/debian/pool/main/liba/libappindicator/libappindicator3-1_0.4.92-7_amd64.deb" && \
    dpkg -i /usr/src/libappindicator3-1_0.4.92-7_amd64.deb ; \
    apt-get install -f -y && \
    rm -f /usr/src/libappindicator3-1_0.4.92-7_amd64.deb

RUN wget -O /usr/src/google-chrome-stable_current_amd64.deb "http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_DRIVER_VERSION}-1_amd64.deb" && \
    dpkg -i /usr/src/google-chrome-stable_current_amd64.deb ; \
    apt-get install -f -y && \
    rm -f /usr/src/google-chrome-stable_current_amd64.deb
RUN google-chrome --version

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

# Add zip utility - it comes in very handy
RUN apt-get update && apt-get install -y \
    zip \
    bzip2 \
    # add codecs needed for video playback in firefox
    # https://github.com/cypress-io/cypress-docker-images/issues/150
    mplayer

# add codecs needed for video playback in firefox
# https://github.com/cypress-io/cypress-docker-images/issues/150
RUN apt-get install mplayer -y

# Set up Chromedriver Environment variables
RUN mkdir $CHROMEDRIVER_DIR

# Add jfrog cli
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod 777 /usr/local/bin/jfrog

# install dumb-init
# https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init

RUN npm install -g npm@8.5.5

USER node
VOLUME /home/node
EXPOSE 9222
EXPOSE 8080
EXPOSE 3000
EXPOSE 49152
EXPOSE 4200
ENTRYPOINT ["dumb-init", "--"]
CMD ["node"]