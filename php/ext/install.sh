#!/bin/sh
apk add -U --no-cache --virtual temp g++ file re2c make autoconf zlib-dev libtool pcre-dev libxml2-dev bzip2-dev libzip-dev \
    icu-dev gettext-dev imagemagick-dev openldap-dev libpng-dev gmp-dev yaml-dev postgresql-dev \
    libxml2-dev tidyhtml-dev libmemcached-dev libssh2-dev libevent-dev libev-dev lua-dev \
    freetype freetype-dev libpng libjpeg-turbo  libjpeg-turbo-dev
# prod deps
apk add --no-cache icu gettext imagemagick libzip libbz2 libxml2-utils openldap-back-mdb openldap yaml \
      libpq tidyhtml imap-dev libmemcached libssh2 libevent libev lua git \

docker-php-ext-configure gd --with-freetype --with-jpeg
docker-php-ext-install -j$(nproc) gd pcntl pdo_mysql mysqli exif sockets gettext intl soap bcmath opcache zip 

extName="redis"
mkdir ${extName}
tar -xf redis-5.2.0.tgz -C ${extName} --strip-components=1
(cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
docker-php-ext-enable ${extName}

extName="swoole"
mkdir ${extName}
tar -xf swoole-4.5.2.tgz -C ${extName} --strip-components=1
(cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
docker-php-ext-enable ${extName}

apk del temp