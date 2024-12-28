FROM php:8.2.26-bookworm

ARG TIMEZONE=Asia/Shanghai
ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="shangminxiao@gmail.com"

RUN ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone

RUN curl https://chsrc.run/posix | bash && \
    chsrc set debian

RUN set -ex && \
    apt update && \
    apt install -y --no-install-recommends libssl-dev git python3 python3-pip python3-dev libpng-dev libwebp-dev libjpeg-dev libfreetype6-dev \
        libicu-dev libxml2 libxml2-dev libzip-dev ffmpeg gifsicle \ 
        && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
        && docker-php-ext-install -j$(nproc) \
            gd \
            pcntl \
            pdo_mysql \
            mysqli \
            exif \
            sockets \
            gettext \
            intl \
            soap \
            bcmath \
            opcache \
            zip  \
        && apt-get clean  \
        && rm -rf /var/lib/apt/lists/*

RUN set -ex \
    && pecl channel-update pecl.php.net \
    && pecl install phpy redis \
    && pecl install -D 'enable-sockets="yes" enable-openssl="yes" enable-http2="yes" enable-mysqlnd="yes" enable-swoole-json="no"' swoole \
    && docker-php-ext-enable phpy redis swoole \
    && docker-php-source delete \
    && rm -rf /tmp/*

RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ 
    
ENV COMPOSER_HOME=/tmp/composer

# USER www-data
WORKDIR /var/www/html