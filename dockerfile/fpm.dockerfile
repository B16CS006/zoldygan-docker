FROM php:7.4-fpm

RUN apt update -y --no-install-recommends

RUN apt update && apt install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev libxml2-dev libcurl4-gnutls-dev

RUN docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

CMD ["php-fpm"]
