#!/bin/sh
apk --update add --no-cache --virtual .build-deps autoconf g++ libtool make curl-dev gettext-dev linux-headers

apk --no-cache add git file-dev imagemagick-dev gettext-dev libzip-dev icu-dev freetype freetype-dev libpng libpng-dev libjpeg-turbo libjpeg-turbo-dev libwebp-dev libxml2-dev

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
 
  
pecl install protobuf
docker-php-ext-enable protobuf
pecl install -D 'enable-sockets="no" enable-openssl="yes" enable-http2="yes" enable-mysqlnd="yes" enable-swoole-json="no" enable-swoole-curl="yes" enable-cares="yes"' swoole
docker-php-ext-enable swoole
pecl install imagick
docker-php-ext-enable imagick



installExtensionFromTgz()
{
    tgzName=$1
    extensionName="${tgzName%%-*}"

    mkdir ${extensionName}
    tar -xf ${tgzName}.tgz -C ${extensionName} --strip-components=1
    ( cd ${extensionName} && phpize && ./configure && make -j$(nproc) && make install )

    docker-php-ext-enable ${extensionName} $2
}


installExtensionFromTgz redis-5.2.0

apk del .build-deps && docker-php-source delete