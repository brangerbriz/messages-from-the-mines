#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ -z "$EMAIL" ] || [ -z "$DOMAIN" ] ; then
    echo "Error: EMAIL and DOMAIN env vars must be set. exiting."
    exit 1
fi

docker run \
    -v "${DIR}/../ssl:/var/www/letsencrypt" \
    -v "${DIR}/../letsencrypt:/etc/letsencrypt" \
    --rm certbot/certbot \
    certonly --webroot --non-interactive \
    --email "$EMAIL" \
    --agree-tos \
    -w /var/www/letsencrypt \
    -d "$DOMAIN"