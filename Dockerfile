#
# Youpin Development Environment Dockerfile
# Version 1.0
#
FROM ubuntu:16.04
MAINTAINER Youpin <developer@yoyohr.com>

COPY home /home
VOLUME /home/data

#Update sources.list
COPY sources.list /etc/apt/sources.list

#Update nginx.list
COPY nginx/nginx.list /etc/apt/sources.list.d/nginx.list
COPY nginx/nginx_signing.key /root/nginx_signing.key

# Install packages
RUN apt-key add /root/nginx_signing.key \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" \
        apt-get install -y \
        ca-certificates \
        curl \
        libpcre3 \
        librecode0 \
        libsqlite3-0 \
        libxml2 \
        --no-install-recommends \
    && DEBIAN_FRONTEND="noninteractive" \
        apt-get install -y nginx \
        --no-install-recommends \
    && DEBIAN_FRONTEND="noninteractive" \
        apt-get install -y php7.0-fpm \
        php7.0-cli \
        php7.0-gd \
        php7.0-curl \
        php7.0-mbstring \
        php7.0-mysql \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY nginx/nginx.conf /etc/nginx/

COPY start_youpin_env /usr/local/bin/

RUN chmod 755 /usr/local/bin/start_youpin_env

EXPOSE 80 443
ENTRYPOINT ["start_youpin_env"]