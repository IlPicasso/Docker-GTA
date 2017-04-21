# Dockerfile for SAMP on Pterodactyl Panel
#    && apt-add-architecture i386 \
#FROM frolvlad/alpine-glibc
FROM ubuntu:16.04

MAINTAINER Stefano Ortiz <staff+staff@comugamers.com>

#RUN apk update \
#    && apk upgrade \
#    && echo "http://nl.alpinelinux.org/alpine/latest-stable/main/" >> /etc/apk/repositories \
#    && apk add --no-cache curl bash ca-certificates openssl perl wget psmisc libstdc++ \
#    && apk update \
#    && apk upgrade \
#    && adduser -D -h /home/container container



RUN apt-get update && apt-get install -y wget psmisc curl openssl ca-certificates perl libtbb-dev \
 && apt-get update \
 dpkg --add-architecture i386 \
 apt-get update \
 apt-get install libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 \
 apt-get update \
 && apt-get install -y lib32stdc++6 \
 && adduser -D -h /home/container container

USER container
ENV USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
