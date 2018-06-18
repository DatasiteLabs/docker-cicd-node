FROM openjdk:8-jdk
LABEL version="1.0" maintainer="Kayla Altepeter"
ENV SONAR_SCANNER_VERSION 3.0.3.778
ENV NODE_VERSION 8.9.4

  # Add a chrome user and setup home dir.
RUN groupadd --system --gid 1000 node && \
    useradd --system --create-home --uid 1000 --gid node --groups audio,video --shell /bin/bash node && \
    mkdir --parents /home/node/reports && \
    chown --recursive node:node /home/node

USER node

RUN apt-get update && curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
	 apt-get install -y nodejs && \
	 apt-get install -y build-essential

# http://phantomjs.org/download.html
# install phantomjs
RUN apt-get update && apt-get install -y --no-install-recommends git \
	libfontconfig && \
	wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
	tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/ && \
	ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/

# https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner
# install sonar-scanner
RUN apt-get update && apt-get install -y --no-install-recommends \
	unzip && \
	wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
	unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux -d /usr/local/share/ && \
	chown -R node: /usr/local/share/sonar-scanner-${SONAR_SCANNER_VERSION}-linux

ENV SONAR_RUNNER_HOME "/usr/local/share/sonar-scanner-${SONAR_SCANNER_VERSION}-linux"

ENV PATH="${SONAR_RUNNER_HOME}/bin:${PATH}"
VOLUME /home/node
EXPOSE 3000
CMD ["node"]
