FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y build-essential net-tools iputils-ping iproute2 curl git

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g watchify

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn

RUN apt update &&  apt install -y curl git python3 python3-pip build-essential redis openssl libssl-dev pkg-config

RUN git clone https://github.com/edumeet/edumeet.git
# RUN cd edumeet && git checkout develop
RUN cd edumeet && cp server/config/config.example.js server/config/config.js

RUN cd  / && cd edumeet/app && yarn && yarn build

RUN cd / && cd edumeet/server && yarn && yarn build

EXPOSE 3000
EXPOSE 2000-2020
EXPOSE 10000-10100