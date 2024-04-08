FROM php:8.3.4-bookworm

ARG TIMEZONE=Asia/Shanghai
ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="shangminxiao@gmail.com"

RUN set -ex && \
    apt update && \
    apt install -y --no-install-recommends libssl-dev git python3 python3-pip python3-dev libpng-dev libwebp-dev libjpeg-dev libfreetype6-dev \
        libicu-dev libxml2 libxml2-dev libzip-dev  && \ 
        rm -rf /var/lib/apt/lists/*

# phpy
RUN git clone https://github.com/swoole/phpy.git /tmp/phpy && \
    cd /tmp/phpy && \
    docker-php-source extract && \
    phpize && \
    ./configure --with-python-config=/usr/bin/python3-config && \
    make && make install && \
    docker-php-ext-enable phpy && \
    rm -rf /tmp/phpy

COPY ./ext /tmp/ext
WORKDIR /tmp/ext

RUN chmod +x install.sh \
    && sh install.sh \
    && rm -rf /tmp/ext

RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ 
    
ENV COMPOSER_HOME=/tmp/composer

# USER www-data
WORKDIR /var/www/html