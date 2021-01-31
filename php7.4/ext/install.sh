#!/bin/sh
apk --update add --no-cache --virtual .build-deps autoconf g++ libtool make curl-dev linux-headers libevent-dev freetype-dev  libpng-dev libjpeg-turbo-dev

apk --no-cache add git gettext-dev libzip-dev icu-dev freetype libpng libjpeg-turbo libwebp-dev rabbitmq-c-dev libxml2-dev

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
 
# pecl install protobuf
# docker-php-ext-enable protobuf
pecl install yac
docker-php-ext-enable yac
pecl install grpc
docker-php-ext-enable grpc

extName="protobuf"
mkdir ${extName}
tar -xf protobuf-3.14.0.tgz -C ${extName} --strip-components=1
(cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
docker-php-ext-enable ${extName}

extName="redis"
mkdir ${extName}
tar -xf redis-5.2.0.tgz -C ${extName} --strip-components=1
(cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
docker-php-ext-enable ${extName}

extName="swoole"
mkdir ${extName}
tar -xf swoole-4.5.9.tgz -C ${extName} --strip-components=1
(cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
docker-php-ext-enable ${extName}


extName="mongodb"
mkdir ${extName}
tar -xf mongodb-1.9.0.tgz -C ${extName} --strip-components=1
(cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
docker-php-ext-enable ${extName}

apk del .build-deps 