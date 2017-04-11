# Dockerfile for TS3 on Pterodactyl Panel
FROM ubuntu:14.04 

MAINTAINER Stefano Ortiz <staff+staff@comugamers.com>

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl ca-certificates openssl perl \
    && adduser -D -h /home/container container \
	&& apt-get install -y \
 lib32stdc++6 \
 wget \
 psmisc


USER container
ENV USER container
ENV HOME /home/container
ENV SAMP_VERSION 0.3.7

WORKDIR /home/container

COPY ./start.sh /start.sh

CMD ["/bin/ash", "/start.sh"]
