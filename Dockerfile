# Dockerfile for SAMP on Pterodactyl Panel
#    && apt-add-architecture i386 \
FROM frolvlad/alpine-glibc

MAINTAINER Stefano Ortiz <staff+staff@comugamers.com>

RUN apk update \
    && apk upgrade \
    && apk add curl ca-certificates openssl perl \
    && apk add \
 lib32stdc++6 \
 wget \
 psmisc \
    && apk update \
    && apk get \
    && apk upgrade \
    && adduser -D -h /home/container container


USER container
ENV USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
