FROM node:8-stretch

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y libzmq3-dev jq && \
    apt-get -y autoremove

ADD ./mftm-backend /mftm-backend
WORKDIR  /mftm-backend

ARG BASIC_AUTH_PASSWORD
ARG MYSQL_USER
ARG MYSQL_ROOT_PASSWORD
ARG HTTPS_PORT

RUN sed -i "s/change-me-or-get-pwned/${BASIC_AUTH_PASSWORD}/" www/review/auth.js
RUN TMP=$(mktemp) && \
    jq ".port = ${HTTPS_PORT} | .basicAuth.users.admin = \"${BASIC_AUTH_PASSWORD}\" | .mysql.user = \"${MYSQL_USER}\" | .mysql.host = \"db\" | .mysql.password = \"${MYSQL_ROOT_PASSWORD}\"" config.json > "$TMP" && \
    mv "$TMP" config.json

RUN npm install
CMD node server