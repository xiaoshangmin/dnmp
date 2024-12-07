#!/bin/sh
set -ex

docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp
docker-php-ext-install -j$(nproc) gd
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

pecl channel-update pecl.php.net
#pecl install imagick
#docker-php-ext-enable imagick
pecl install phpy
docker-php-ext-enable phpy
# pecl install ffmpeg
# docker-php-ext-enable ffmpeg
pecl install redis
docker-php-ext-enable redis
pecl install -D 'enable-sockets="yes" enable-openssl="yes" enable-http2="yes" enable-mysqlnd="yes" enable-swoole-json="no"' swoole
docker-php-ext-enable swoole
docker-php-source delete

