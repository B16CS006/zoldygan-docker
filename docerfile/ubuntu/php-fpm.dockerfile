FROM ubuntu:21.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y --no-install-recommends  && apt upgrade -y
RUN apt-get install -y --no-install-recommends php-fpm php-mysql
CMD php-fpm7.4
