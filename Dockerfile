# Dockerfile for SAMP on Pterodactyl Panel
FROM frolvlad/alpine-glibc

MAINTAINER Stefano Ortiz <staff+staff@comugamers.com>

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl ca-certificates openssl perl \
    && apt-get install -y \
 lib32stdc++6 \
 libstdc++6 \
 wget \
 psmisc \
    && apt-get update \
    && apt-add-architecture i386 \
    && apt-get install -y \
 lib32stdc++6 \
    && apt-get upgrade -y \
    && adduser -D -h /home/container container


USER container
ENV USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh

CMD ["/bin/ash", "/start.sh"]
