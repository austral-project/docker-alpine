# Dockerfile.alpine
FROM alpine:3.23
LABEL maintainer="Matthieu Beurel <matthieu@austral.dev>"

# Default vars
ARG TZ="Europe/Paris"
ARG USER_ID=1000
ARG GROUP_ID=1000


# Packages
RUN apk update && apk upgrade && apk add --update --no-cache \
    bash \
    bash-completion \
    bash-doc \
    vim \
    curl \
    wget \
    git \
    unzip \
    make \
    procps \
    shadow \
    gettext \
    tzdata \
    ca-certificates \
    zlib \
    libxml2 \
    openssl \
    zip \
    json-glib \
    && rm -rf /var/cache/apk/*

RUN adduser -u ${USER_ID} -S -h /home/www-data -G www-data -D -s /bin/bash www-data \
  && groupmod -g ${GROUP_ID} www-data \
  && mkdir -p /home/www-data/website \
  && chown -R www-data:www-data /home/www-data

COPY config/profile /home/www-data/.profile
COPY config/bashrc /home/www-data/.bashrc
COPY config/vimrc /home/www-data/.vimrc


RUN chown www-data:www-data /home/www-data/.profile \
    && chmod 644 /home/www-data/.profile \
    && chown www-data:www-data /home/www-data/.bashrc \
    && chmod 644 /home/www-data/.bashrc \
    && chown www-data:www-data /home/www-data/.vimrc \
    && chmod 644 /home/www-data/.vimrc

RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && echo ${TZ} >  /etc/timezone

WORKDIR /home/www-data/website
USER www-data