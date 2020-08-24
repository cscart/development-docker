FROM php:5.6-fpm

RUN set -xe; \
    apt update; \
    apt install --yes \
        mariadb-client \
        git \
        zip unzip \
        curl \
        libzip-dev libcurl4-gnutls-dev libpng-dev libxml2-dev libjpeg-dev libfreetype6-dev \
        libmagickwand-dev; \
    curl -sL https://deb.nodesource.com/setup_10.x | bash -; \
    apt install -y nodejs; \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
    docker-php-ext-install pdo_mysql gd json zip intl soap mbstring bcmath curl sockets; \
    pecl install imagick; \
    docker-php-ext-enable imagick

# RUN set -xe ; \
#     pecl install xdebug; \
#     docker-php-ext-enable xdebug
