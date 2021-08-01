FROM ubuntu:21.04

RUN apt-get update -y --no-install-recommends  && apt upgrade -y
RUN apt-get install -y --no-install-recommends npm
RUN npm install -g ngrok
CMD ngrok http 80

