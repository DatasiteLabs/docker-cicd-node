FROM node:8
RUN apt-get update && apt-get install -y --no-install-recommends git && \
	apt-get install -y libfontconfig && \
	wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
	tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/ && \
	ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/
EXPOSE 3000
ENTRYPOINT ["node"]