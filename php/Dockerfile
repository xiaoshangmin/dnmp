FROM php:7.4.2-fpm-alpine

LABEL  maintainer="778900778@qq.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY ./ext /tmp/ext
WORKDIR /tmp/ext

RUN apk add --no-cache --virtual .build-deps icu-dev libstdc++ ${PHPIZE_DEPS} autoconf freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \    
    && docker-php-ext-install  -j$(nproc) intl gd sockets pdo pdo_mysql zip opcache pcntl \  
    && apk del \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev \ 
    && chmod a+x install.sh \
    && sh install.sh \
    && rm -rf /tmp/* \
    && apk del .build-deps \
    && docker-php-source delete

RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer \
    && composer config -g secure-http false \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ 

USER www-data
WORKDIR /var/www/html