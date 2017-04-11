# Dockerfile for TS3 on Pterodactyl Panel
FROM frolvlad/alpine-glibc

MAINTAINER Dane Everitt <dane+docker@daneeveritt.com>

RUN apk update \
    && apk upgrade \
    && apk add --update curl ca-certificates openssl perl \
    && adduser -D -h /home/container container

USER container
ENV USER container
ENV HOME /home/container
ENV TS_VERSION 3.0.13.4

WORKDIR /home/container

COPY ./start.sh /start.sh

CMD ["/bin/ash", "/start.sh"]
