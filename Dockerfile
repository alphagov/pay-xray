FROM govukpay/alpine:latest-master

USER root
RUN apk update
RUN apk upgrade

RUN apk add --no-cache libc6-compat curl unzip ca-certificates bash

RUN mkdir workspace

WORKDIR workspace

RUN curl https://s3.dualstack.us-east-1.amazonaws.com/aws-xray-assets.us-east-1/xray-daemon/aws-xray-daemon-linux-2.x.zip -o install.zip
RUN unzip ./install.zip
RUN mv xray /usr/bin/xray

WORKDIR /

RUN rm -rf workspace
RUN apk del unzip

ADD src/files/run-with-config.sh run-with-config.sh
CMD bash ./run-with-config.sh

EXPOSE 2000/udp
