#!/bin/sh
apk --update add --no-cache --virtual .build-deps autoconf g++ libtool make curl-dev linux-headers

apk --no-cache add git gettext-dev libzip-dev icu-dev freetype freetype-dev libpng libpng-dev libjpeg-turbo libjpeg-turbo-dev libwebp-dev libxml2-dev

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
 
 
pecl install yac-2.0.2
docker-php-ext-enable yac  
pecl install protobuf
docker-php-ext-enable protobuf

extName="redis"
mkdir ${extName}
tar -xf redis-5.2.0.tgz -C ${extName} --strip-components=1
(cd ${extName} && phpize && ./configure && make -j$(nproc) && make install)
docker-php-ext-enable ${extName}

extName="xbebug"
mkdir ${extName}
tar -xf xbebug-3.1.2.tgz -C ${extName} --strip-components=1
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