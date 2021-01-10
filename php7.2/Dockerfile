FROM php:7.2.34-fpm-alpine

LABEL  maintainer="shangminxiao@gmail.com"

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g" /etc/apk/repositories

COPY ./ext /tmp/ext
WORKDIR /tmp/ext

RUN chmod +x install.sh \
    && sh install.sh \
    && rm -rf /tmp/ext

RUN apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime \
    && echo "$TIMEZONE" > /etc/timezone \
    && apk del tzdata

RUN apk add gnu-libiconv libstdc++ --no-cache --repository http://mirrors.aliyun.com/alpine/edge/community/ --allow-untrusted
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer
    # && composer config -g secure-http false \
    # && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ 
ENV COMPOSER_HOME=/tmp/composer

# php image's www-data user uid & gid are 82, change them to 1000 (primary user)
RUN apk --no-cache add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data

# USER www-data
WORKDIR /var/www/html