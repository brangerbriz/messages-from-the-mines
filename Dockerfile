FROM node:8-stretch
LABEL maintainer="bdorsey@brangerbriz.com"

# general update and upgrade
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y curl git && \
    apt-get -y autoremove

RUN useradd -d /home/noroot -ms /bin/bash noroot
RUN chown -R noroot:noroot /home/noroot
USER noroot

# copy the ethereum folder to the home directory
ADD --chown=noroot:noroot ./ /home/noroot/emerge2016
WORKDIR /home/noroot/emerge2016/data
RUN curl -o thumbnails.tar.gz -L \
    https://github.com/brangerbriz/emerge2016/releases/download/v1.0/thumbnails.tar.gz
RUN tar xzf thumbnails.tar.gz

WORKDIR /home/noroot/emerge2016/microsite
RUN git checkout emerge-docker
RUN npm install

CMD sleep 10 && node server