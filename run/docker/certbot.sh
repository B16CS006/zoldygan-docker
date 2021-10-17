#!/bin/bash

CERTIFY_URL="${CERTBOT_CERTIFY_URL:-""}"
FLOCK_URL="${CERTBOT_FLOCK_URL:-""}"
WORKDIR="${CERTBOT_WORKDIR:-"/home/chetanprakashmeena13/certbot"}"
TYPE="${CERTBOT_TYPE:-"webroot"}"
DOMAIN_FILE="${CERTBOT_DOMAIN_FILE:-"domains"}"
EXPIRE_DAYS="${CERTBOT_EXPIRE_DAYS:-"30"}"

# mkdir $WORKDIR || true # we are managing this folder using puppet

if [[ "$1" = "apply" ]]; then
    TEST_OPTS=""
elif [[ "$1" = "test" ]]; then
    TEST_OPTS="--dry-run --test-cert"
else
    echo '$1 should either be apply or test'
    exit 1
fi

if [[ "$TYPE" = "dns" ]]; then
    DOCKER_OPTS="-v $WORKDIR/dnsmadeeasy.ini:/secrets/certbot/dnsmadeeasy.ini"
    CERTBOT_OPTS="--dns-dnsmadeeasy --dns-dnsmadeeasy-credentials /secrets/certbot/dnsmadeeasy.ini --preferred-challenges=dns"
elif [[ "$TYPE" = "webroot" ]]; then
    DOCKER_OPTS="-v $WORKDIR/www:/var/www/html"
    CERTBOT_OPTS="--webroot -w /var/www/html"
else
    echo "Not a proper type"
    exit 1
fi

send_flock_notification () {
  echo $1;
#	curl -s -X POST "$FLOCK_URL" -H "Content-Type: application/json" -d "{\"text\": \"$1\"}" || echo "DEBUG: $1"
}

for domain in `grep -v "^[#[:space:]]\|^[[:space:]]*$" $WORKDIR/$DOMAIN_FILE.txt`;do
    # short_domain=`sed 's/^*.//' <<< $domain`
    echo
    echo "===== Certificate for $domain[$short_domain] ======";

    # Check if cert expire on certify
    # curl -s "$CERTIFY_URL/api/down?dn=$domain&type=fullchain" | openssl x509 -noout -checkend $(( 24*3600*$EXPIRE_DAYS )) 1>/dev/null 2>&1 && { echo "Certificate already update-to-date on Certify"; continue; } || echo "Certificate are not update-to-date on Certify";

    # Certify cert is not updated check if locally we had updated certicates for this domain
    openssl x509 -noout -checkend $(( 24*3600*$EXPIRE_DAYS )) -in $WORKDIR/letsencryptetc/archive/$domain/fullchain1.pem 1>/dev/null 2>&1 && echo "Certificate are update-to-date locally" || {
        echo "Certificate are not update-to-date locally so generating certificate";
        docker run -it --rm --name certbot-dns \
            -v $WORKDIR/letsencryptetc:/etc/letsencrypt \
            -v $WORKDIR/letsencryptlib:/var/lib/letsencrypt \
            -v $WORKDIR/log:/var/log/letsencrypt \
            $DOCKER_OPTS \
            certbot/certbot \
            certonly $CERTBOT_OPTS -d "$domain" --agree-tos -m chetanprakashmeena13@gmail.com $TEST_OPTS -n || send_flock_notification "Certificate generation failed for $domain"; }
    if [[ "$1" = "apply" ]]; then
        echo "Uploading certs to certify..."
        cp $WORKDIR/letsencryptetc/archive/$domain/fullchain1.pem /opt/docker/config/nginx/certs/$domain.crt;
        cp $WORKDIR/letsencryptetc/archive/$domain/privkey1.pem /opt/docker/config/nginx/certs/$domain.key;
        send_flock_notification "Certificate updated for $domain"
    fi
done
