FROM php:8.3.4-fpm-alpine

ARG TIMEZONE=Asia/Shanghai

LABEL maintainer="shangminxiao@gmail.com"

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g" /etc/apk/repositories

RUN set -ex && \
    apk --update add --no-cache --virtual .build-deps autoconf m4 g++ libtool make curl-dev linux-headers build-base && \
    apk --no-cache add python3 python3-dev py3-pip git file-dev imagemagick-dev imagemagick freetype freetype-dev gettext-dev libpng libpng-dev libjpeg-turbo libjpeg-turbo-dev libwebp-dev icu-dev libxml2-dev libzip-dev

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

RUN apk del .build-deps freetype-dev libpng-dev libjpeg-turbo-dev && docker-php-source delete

RUN apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime \
    && echo "$TIMEZONE" > /etc/timezone

# Fix: https://github.com/docker-library/php/issues/240
RUN apk add gnu-libiconv libstdc++ --no-cache --repository http://mirrors.ustc.edu.cn/alpine/edge/community/ --allow-untrusted
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

#apk add libreoffice
# RUN apk add fontconfig mkfontscale wqy-zenhei --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing --allow-untrusted

RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ 
    
ENV COMPOSER_HOME=/tmp/composer


# php image's www-data user uid & gid are 82, change them to 1000 (primary user)
RUN apk --no-cache add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data

# USER www-data
WORKDIR /var/www/html