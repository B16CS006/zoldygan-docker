#!/bin/bash

OPTS="--dry-run --test-cert"
WORKDIR="${CERTBOT_WORKDIR:-"/home/chetanprakashmeena13/certbot"}"

mkdir $WORKDIR || true

if [[ "$1" = "apply" ]]; then
  OPTS=""
fi

for domain in `grep -v "^[#[:space:]]\|^[[:space:]]*$" /opt/docker/config/certbot/domains.txt`;do
  echo "===== Creating certificate for $domain ======";
  docker run -it --rm --name certbot-dns \
    -v $WORKDIR/letsencryptetc:/etc/letsencrypt \
    -v $WORKDIR/letsencryptlib:/var/lib/letsencrypt \
    -v $WORKDIR/log:/var/log/letsencrypt \
    -v $WORKDIR/www:/var/www/html \
    certbot/certbot certonly --webroot -w /var/www/html -d "$domain" --agree-tos -m chetanprakashmeena13@gmail.com $OPTS -n;
  if [[ "$1" = "apply" ]]; then
    cp $WORKDIR/letsencryptetc/archive/$domain/fullchain1.pem /opt/docker/config/nginx/certs/$domain.crt;
    cp $WORKDIR/letsencryptetc/archive/$domain/privkey1.pem /opt/docker/config/nginx/certs/$domain.key;
  fi
done