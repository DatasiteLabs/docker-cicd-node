FROM openjdk:8-jdk
ENV SONAR_SCANNER_VERSION 3.0.3.778

# install node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
	apt-get update && \
	apt-get install -y --no-install-recommends nodejs \
		build-essential

# install phantomjs
RUN apt-get update && apt-get install -y --no-install-recommends git \
	libfontconfig && \
	wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
	tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/ && \
	ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/

# install sonar-scanner
RUN apt-get update && apt-get install -y --no-install-recommends \
	unzip && \
	wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
	unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux -d /usr/local/share/

ENV SONAR_RUNNER_HOME "/usr/local/share/sonar-scanner-${SONAR_SCANNER_VERSION}-linux"

ENV PATH="${SONAR_RUNNER_HOME}/bin:${PATH}"
EXPOSE 3000
ENTRYPOINT ["node"]