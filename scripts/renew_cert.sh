#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

docker run \
    -v "${DIR}/../ssl:/var/www/letsencrypt" \
    -v "${DIR}/../letsencrypt:/etc/letsencrypt"\
    --rm certbot/certbot \
    renew