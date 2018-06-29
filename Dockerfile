FROM cloudron/base:0.10.0

RUN mkdir -p /usr/local/node-10.5.0
RUN curl -L https://nodejs.org/dist/v10.5.0/node-v10.5.0-linux-x64.tar.xz  | tar xfJ - --strip-components 1 -C /usr/local/node-10.5.0
ENV PATH /usr/local/node-10.5.0/bin:$PATH

RUN mkdir -p /app/code
WORKDIR /app/code

RUN curl -L https://github.com/spacedeck/spacedeck-open/archive/master.zip -o master.zip
RUN unzip master.zip
RUN rm master.zip
RUN mv spacedeck-open-master/* spacedeck-open-master/.??* .
RUN rmdir spacedeck-open-master

RUN mkdir /app/data/
RUN touch /app/data/database.sqlite
RUN ln -s /app/data/database.sqlite /app/code

RUN npm install

COPY start.sh /app/code
COPY default.json /app/code/config

CMD [ "/app/code/start.sh" ]

EXPOSE 9666

