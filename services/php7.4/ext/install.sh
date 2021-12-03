#!/bin/sh
apk --update add --no-cache --virtual .build-deps autoconf g++ libtool make curl-dev linux-headers libevent-dev freetype-dev  libpng-dev libjpeg-turbo-dev

apk --no-cache add git gettext-dev libzip-dev icu-dev freetype libpng libjpeg-turbo libwebp-dev libxml2-dev

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
 
 
pecl install yac
docker-php-ext-enable yac
pecl install grpc
docker-php-ext-enable grpc 
pecl install xdebug
docker-php-ext-enable xdebug
pecl install protobuf
docker-php-ext-enable protobuf
pecl install redis
docker-php-ext-enable redis
pecl install swoole
docker-php-ext-enable swoole
pecl install mongodb
docker-php-ext-enable mongodb


apk del .build-deps 