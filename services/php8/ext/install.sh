#!/bin/sh
apk --update add --no-cache --virtual .build-deps autoconf g++ libtool make curl-dev gettext-dev linux-headers

apk --no-cache add git freetype freetype-dev libpng libpng-dev libjpeg-turbo libjpeg-turbo-dev libwebp-dev icu-dev libxml2-dev libzip-dev
docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp
docker-php-ext-install -j$(nproc) gd
apk del freetype-dev libpng-dev libjpeg-turbo-dev

docker-php-ext-install -j$(nproc) pcntl
docker-php-ext-install -j$(nproc) pdo_mysql
docker-php-ext-install -j$(nproc) mysqli
docker-php-ext-install -j$(nproc) exif
docker-php-ext-install -j$(nproc) sockets
docker-php-ext-install -j$(nproc) gettext
docker-php-ext-install -j$(nproc) intl
docker-php-ext-install -j$(nproc) soap
docker-php-ext-install -j$(nproc) bcmath
docker-php-ext-install -j$(nproc) opcache
docker-php-ext-install -j$(nproc) zip
 

pecl install swoole
docker-php-ext-enable swoole
pecl install yac-2.0.2
docker-php-ext-enable yac
pecl install protobuf
docker-php-ext-enable protobuf
pecl install redis
docker-php-ext-enable redis
pecl install mongodb
docker-php-ext-enable mongodb
 

apk del .build-deps && docker-php-source delete