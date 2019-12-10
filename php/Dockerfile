FROM php:7.4-fpm-alpine

MAINTAINER xiaoshangmin

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN apk add --no-cache libstdc++ ${PHPIZE_DEPS}  freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \    
    && docker-php-ext-install  -j$(nproc) gd sockets pdo pdo_mysql \   
    && pecl install redis-5.1.1 \ 
    && pecl install swoole-4.4.12 \
    && docker-php-ext-enable redis swoole \
    && rm -rf /tmp/* \
    && apk del ${PHPIZE_DEPS} \
    && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

WORKDIR /var/www/html