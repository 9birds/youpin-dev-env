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
RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" \
        apt-get install -y \
        python-software-properties \
        software-properties-common \
        ca-certificates \
        curl \
        libpcre3 \
        librecode0 \
        libsqlite3-0 \
        libxml2 \
        --no-install-recommends \
    && apt-key add /root/nginx_signing.key \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" \
        apt-get install -y nginx \
     && DEBIAN_FRONTEND="noninteractive" \
        apt-get install -y php7.0-fpm \
        php7.0-cli \
        php7.0-gd \ 
        php7.0-curl \
        php7.0-mbstring \
        php7.0-mysql \       
    && rm -rf /var/lib/apt/lists/*

COPY nginx/nginx.conf /etc/nginx/

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]




