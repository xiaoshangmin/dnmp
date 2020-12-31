#!/bin/sh
apk --update add --no-cache --virtual .build-deps autoconf g++ m4 gcc libtool make curl-dev gettext-dev \
        linux-headers freetype libmcrypt-dev icu-dev openssl-dev libressl-dev \
        freetype-dev libpng libpng-dev libjpeg-turbo libjpeg-turbo-dev libwebp-dev libzip-dev

docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-webp-dir=/usr/include/ \
docker-php-ext-install -j$(nproc) gd
docker-php-ext-install -j$(nproc) pcntl
docker-php-ext-install -j$(nproc) pdo_mysql
docker-php-ext-install -j$(nproc) mysqli
docker-php-ext-install -j$(nproc) exif
docker-php-ext-install -j$(nproc) sockets
# docker-php-ext-install -j$(nproc) gettext
# docker-php-ext-install -j$(nproc) intl
docker-php-ext-install -j$(nproc) soap
docker-php-ext-install -j$(nproc) bcmath
docker-php-ext-install -j$(nproc) opcache
docker-php-ext-install -j$(nproc) zip

# extName="redis"
# mkdir ${extName}
# tar -xf redis-5.2.0.tgz -C ${extName} --strip-components=1
# (cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
# docker-php-ext-enable ${extName}

extName="swoole"
mkdir ${extName}
tar -xf swoole-4.5.9.tgz -C ${extName} --strip-components=1
(cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
docker-php-ext-enable ${extName}

# extName="amqp"
# mkdir ${extName}
# tar -xf amqp-1.10.2.tgz -C ${extName} --strip-components=1
# (cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
# docker-php-ext-enable ${extName}

apk del .build-deps