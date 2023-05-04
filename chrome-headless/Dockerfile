FROM node:16.20-bullseye-slim
ARG TARGETPLATFORM
ARG TARGETARCH
LABEL version="1.2" maintainer="Kayla Altepeter"
# https://github.com/cypress-io/cypress-docker-images/blob/master/factory/.env should have compatible versions
ENV CHROME_DRIVER_VERSION 112.0.5615.121
ENV CHROMEDRIVER_DIR /chromedriver
# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH
ENV GH_CLI_VERSION 2.28.0

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
    # cypress deps: https://docs.cypress.io/guides/continuous-integration/introduction#Dependencies
    libgtk2.0-0 \
    libgtk-3-0 \
    libnotify-dev \
    libgconf-2-4 \
    libgbm-dev \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    procps \
    xauth \
    xvfb \
    # install text editors
    vim-tiny \
    nano \
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
RUN curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/${TARGETARCH}" && \
  chmod +x mkcert-v*-linux-${TARGETARCH} && \
  mv mkcert-v*-linux-${TARGETARCH} /usr/local/bin/mkcert

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
# https://github.com/cypress-io/cypress-docker-images/blob/master/browsers/node16.18.0-chrome107-ff106-edge/Dockerfile
RUN apt-get update && \
    apt-get install -y \
    fonts-liberation \
    git \
    libcurl4 \
    libcurl3-gnutls \
    libcurl3-nss \
    xdg-utils \
    wget \
    curl \
    zip \
    libu2f-udev \
    # firefox dependencies
    bzip2 \
    # add codecs needed for video playback in firefox
    # https://github.com/cypress-io/cypress-docker-images/issues/150
    mplayer \
    # edge dependencies
    gnupg \
    dirmngr \
    # clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# install libappindicator3-1 - not included with Debian 11
RUN wget --no-verbose /usr/src/libappindicator3-1_0.4.92-7.deb "https://ftp.us.debian.org/debian/pool/main/liba/libappindicator/libappindicator3-1_0.4.92-7_${TARGETARCH}.deb" && \
    dpkg -i /usr/src/libappindicator3-1_0.4.92-7.deb ; \
    apt-get install -f -y && \
    rm -f /usr/src/libappindicator3-1_0.4.92-7.deb

RUN node -p "process.arch === 'arm64' ? 'Not downloading Chrome since we are on arm64: https://crbug.com/677140' : process.exit(1)" || \
    wget -O /usr/src/google-chrome-stable_current.deb "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_DRIVER_VERSION}-1_${TARGETARCH}.deb" && \
    dpkg -i /usr/src/google-chrome-stable_current.deb ; \
    apt-get install -f -y && \
    rm -f /usr/src/google-chrome-stable_current.deb && \
    google-chrome --version

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

# Set up Chromedriver Environment variables
RUN mkdir $CHROMEDRIVER_DIR

# Add jfrog cli
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod 777 /usr/local/bin/jfrog

# Add github cli
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install gh=${GH_CLI_VERSION} -y

# install dumb-init
# https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init

RUN npm install -g npm@8

USER node
VOLUME /home/node
EXPOSE 9222
EXPOSE 8080
EXPOSE 3000
EXPOSE 49152
EXPOSE 4200
ENTRYPOINT ["dumb-init", "--"]
CMD ["node"]
