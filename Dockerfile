FROM cloudron/base:0.10.0

RUN apt-get update
RUN apt-get install -y python build-essential cmake git-core graphicsmagick imagemagick wget libfreetype6 \
  libfontconfig bzip2 curl libtheora0 poppler-utils unzip zip libav-tools libavcodec-extra \
  checkinstall libmad0-dev libsndfile1-dev libgd2-xpm-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev libid3tag0-dev libid3tag0

RUN git clone https://github.com/bbcrd/audiowaveform.git
RUN cd audiowaveform && wget https://github.com/google/googletest/archive/release-1.8.0.tar.gz && \
  tar xzf release-1.8.0.tar.gz && \
  ln -s googletest-release-1.8.0/googletest googletest && \
  ln -s googletest-release-1.8.0/googlemock googlemock

RUN cd audiowaveform && mkdir build && cd build && cmake .. && make && make install

ENV PHANTOMJS_VERSION=2.1.1
RUN wget -q --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2
RUN tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp
RUN mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /usr/local/phantomjs
RUN ln -s /usr/local/phantomjs/bin/phantomjs /usr/bin/phantomjs

RUN mkdir -p /usr/local/node-10.5.0
RUN curl -L https://nodejs.org/dist/v10.5.0/node-v10.5.0-linux-x64.tar.xz  | tar xfJ - --strip-components 1 -C /usr/local/node-10.5.0
ENV PATH /usr/local/node-10.5.0/bin:$PATH

RUN mkdir -p /app/code
WORKDIR /app/code

RUN curl -L https://github.com/kaleidos/spacedeck-open/archive/master.zip -o master.zip
RUN unzip master.zip
RUN rm master.zip
RUN mv spacedeck-open-master/* spacedeck-open-master/.??* .
RUN rmdir spacedeck-open-master

RUN mkdir /app/data/
RUN touch /app/data/database.sqlite
RUN ln -s /app/data/database.sqlite /app/code

RUN mkdir /app/data/storage
RUN ln -s /app/data/storage /app/code/storage

RUN npm install

COPY start.sh /app/code
RUN ln -sf /run/
COPY default.template.json /app/code/config/default.template.json
RUN ln -sf /run/default.json /app/code/config/default.json

CMD [ "/app/code/start.sh" ]

EXPOSE 9666
