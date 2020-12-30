FROM php:7.4.13-fpm-buster

LABEL  maintainer="shangminxiao@gmail.com"

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    librabbitmq-dev \
&& docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
&& docker-php-ext-install -j$(nproc) gd pcntl pdo_mysql mysqli exif sockets gettext intl soap bcmath opcache zip 


COPY ./ext /tmp/ext
WORKDIR /tmp/ext

RUN chmod +x install.sh \
    && sh install.sh \
    && rm -rf /tmp/*

RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer
    # && composer config -g secure-http false \
    # && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ 
ENV COMPOSER_HOME=/tmp/composer

USER www-data
WORKDIR /var/www/html