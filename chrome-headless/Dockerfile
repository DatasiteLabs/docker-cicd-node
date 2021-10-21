FROM node:12.22.7-buster-slim
LABEL version="1.2" maintainer="Kayla Altepeter"
ENV CHROME_DRIVER_VERSION 95.0.4638.17
ENV CHROMEDRIVER_DIR /chromedriver
# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

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
    curl \
    libcurl4 \
    # cypress deps
    libgtk2.0-0 \
    libgtk-3-0 \
    libnotify-dev \
    libgconf-2-4 \
    libgbm-dev \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    xvfb

# Set up the Chrome PPA    
RUN wget -qO - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list

# Update the package list and install chrome
RUN apt-get update -y --no-install-recommends
RUN apt-get install -y google-chrome-stable 

# Set up Chromedriver Environment variables
RUN mkdir $CHROMEDRIVER_DIR

# Install latest chrome dev package. following example: old: https://github.com/ebidel/lighthouse-ci/blob/master/builder/Dockerfile
# new: https://gist.github.com/varyonic/dea40abcf3dd891d204ef235c6e8dd79
# Download and install Chromedriver
RUN CHROMEVER=$(google-chrome --product-version | grep -o "[^\.]*\.[^\.]*\.[^\.]*") && \
    DRIVERVER=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROMEVER") && \
    wget -q --continue -P /chromedriver "http://chromedriver.storage.googleapis.com/$DRIVERVER/chromedriver_linux64.zip" && \
    unzip /chromedriver/chromedriver* -d /chromedriver

# Add jfrog cli
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod 777 /usr/local/bin/jfrog

# install dumb-init
# https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init

# a few environment variables to make NPM installs easier
# good colors for most applications
ENV TERM xterm
# avoid million NPM install messages
ENV npm_config_loglevel warn
# allow installing when the main user is root
ENV npm_config_unsafe_perm true

# versions of local tools
RUN echo  " node version:    $(node -v) \n" \
  "npm version:     $(npm -v) \n" \
  "yarn version:    $(yarn -v) \n" \
  "debian version:  $(cat /etc/debian_version) \n" \
  "user:            $(whoami) \n"

USER node
VOLUME /home/node
EXPOSE 3000
EXPOSE 49152
EXPOSE 4200
ENTRYPOINT ["dumb-init", "--"]
CMD ["node"]
