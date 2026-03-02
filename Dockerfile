# Dockerfile.alpine
FROM alpine:3.23
LABEL maintainer="Matthieu Beurel <matthieu@austral.dev>"

# Default vars
ARG TZ="Europe/Paris"
ARG USER_ID=1000
ARG GROUP_ID=1000

# Instal Packages, Create user and dir and config timezone
RUN apk update && apk upgrade && apk add --update --no-cache \
    bash \
    bash-completion \
    curl \
    wget \
    git \
    unzip \
    make \
    procps \
    gettext \
    tzdata \
    ca-certificates \
    zlib \
    libxml2 \
    openssl \
    zip \
    json-glib \
    && rm -rf /var/cache/apk/* \
    && addgroup -g ${GROUP_ID} www-data \
    && adduser -u ${USER_ID} -S -G www-data -h /home/www-data -D -s /bin/bash www-data \
    && mkdir -p /home/www-data/website \
    && chown -R www-data:www-data /home/www-data \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo ${TZ} >  /etc/timezone

# Config file
COPY config/.profile config/.bashrc config/.vimrc /home/www-data/
RUN chown www-data:www-data /home/www-data/.profile /home/www-data/.bashrc /home/www-data/.vimrc \
    && chmod 644 /home/www-data/.profile /home/www-data/.bashrc /home/www-data/.vimrc

#  Init Workdir
WORKDIR /home/www-data/website
USER www-data
ENV HOME=/home/www-data