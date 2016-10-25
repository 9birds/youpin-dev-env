#
# Youpin Development Environment Dockerfile
# Version 1.0
#
FROM ubuntu:16.04
MAINTAINER Youpin <developer@yoyohr.com>

#Update sources.list
COPY sources.list /etc/apt/sources.list

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
    && rm -rf /var/lib/apt/lists/*

COPY nginx.list /etc/apt/sources.list.d/nginx.list
COPY nginx_signing.key /root/nginx_signing.key
COPY home /home
VOLUME /home/data



#COPY php.list /etc/apt/sources.list.d/php.list







RUN apt-get update
RUN apt-key add /root/nginx_signing.key
RUN DEBIAN_FRONTEND="noninteractive"
RUN apt-get install -y nginx

#RUN rm -rf /var/lib/apt/lists/*


#RUN apt-get update
#RUN apt-get install -y nginx

COPY nginx.conf /etc/nginx/




EXPOSE 80 443 9000
CMD ["nginx", "-g", "daemon off;"]
CMD ["php-fpm"]











