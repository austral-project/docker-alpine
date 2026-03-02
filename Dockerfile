FROM alpine:3.23
LABEL maintainer="Matthieu Beurel <matthieu@austral.dev>"

ARG TZ="Europe/Paris"
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN apk update && apk upgrade
RUN apk add --update --no-cache bash \
  bash-completion \
  shadow \
  gettext \
  tzdata \
  ca-certificates \
  zlib-dev \
  zlib \
  libxml2-dev \
  libxml2 \
  openssl \
  curl \
  zip \
  git \
  json-glib

RUN rm -rf /var/cache/apk/*

RUN adduser -u ${USER_ID} -S -h /home/www-data -G www-data -D -s /bin/bash www-data \
  && groupmod -g ${GROUP_ID} www-data \
  && mkdir -p /home/www-data/website \
  && chown -R www-data:www-data /home/www-data

COPY config/profile /home/www-data/.profile
RUN chown www-data:www-data /home/www-data/.profile
RUN chmod 644 /home/www-data/.profile

COPY config/bashrc /home/www-data/.bashrc
RUN chown www-data:www-data /home/www-data/.bashrc
RUN chmod 644 /home/www-data/.bashrc

COPY config/vimrc /home/www-data/.vimrc
RUN chown www-data:www-data /home/www-data/.vimrc
RUN chmod 644 /home/www-data/.vimrc

RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN echo ${TZ} >  /etc/timezone