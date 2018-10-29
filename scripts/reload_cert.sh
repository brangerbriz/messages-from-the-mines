#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ -z "$DOCKER_USER" ] || [ -z "$DOMAIN" ] ; then
    echo "Error: DOCKER_USER and DOMAIN env vars must be set. exiting."
    exit 1
fi

sudo cp "${DIR}/../letsencrypt/live/${DOMAIN}/fullchain.pem" "${DIR}/../ssl/certificate.crt"
sudo cp "${DIR}/../letsencrypt/live/${DOMAIN}/privkey.pem" "${DIR}/../ssl/private.key"
sudo chown $USER:$USER "${DIR}/../certificate.crt"
sudo chown $USER:$USER "${DIR}/../private.key"

docker-compose restart node 