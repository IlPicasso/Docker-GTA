# Dockerfile for SAMP on Pterodactyl Panel
#    && apt-add-architecture i386 \
#FROM frolvlad/alpine-glibc
FROM ubuntu:16.04

#FROM centos:latest

MAINTAINER Stefano Ortiz <staff+staff@comugamers.com>

#RUN apk update \
#    && apk upgrade \
#    && echo "http://nl.alpinelinux.org/alpine/latest-stable/main/" >> /etc/apk/repositories \
#    && apk add --no-cache curl bash ca-certificates openssl perl wget psmisc libstdc++ \
#    && apk update \
#    && apk upgrade \
#    && adduser -D -h /home/container container


 RUN dpkg --add-architecture i386
 RUN apt-get update && apt-get install -y wget psmisc curl openssl ca-certificates perl libtbb-dev \
 && apt-get update \
 #&& dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y libstdc++6 libgcc1 zlib1g libncurses5 \
 && apt-get update \
 && apt-get install -y lib32stdc++6 libtbb2:i386 lib32ncurses5 lib32z1 \
 && adduser -D -h /home/container container


#RUN yum install -y epel-release remi-release \
###    && yum update -y && yum upgrade -y \
  #  && yum install -y ia32-libs mc git wget tar htop bash-completion net-tools tcpdump telnet supervisor libstdc++-devel compat-libstdc++-33.i686 libstdc++.i686 libstdc++-devel.i686 glibc-devel.i686 \
  #  && adduser -D -h /home/container container

USER container
ENV USER container
ENV HOME /home/container

WORKDIR /home/container

COPY ./start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
