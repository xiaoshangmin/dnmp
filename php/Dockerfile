FROM php:7.4.7-fpm-alpine

LABEL  maintainer="shangminxiao@gmail.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY ./ext /tmp/ext
WORKDIR /tmp/ext

RUN chmod +x install.sh \
    && sh install.sh \
    && rm -rf /tmp/*

RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer \
    && composer config -g secure-http false \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ 

USER www-data
WORKDIR /var/www/html