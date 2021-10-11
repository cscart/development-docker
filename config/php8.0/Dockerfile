FROM php:8.0-fpm

ENV VERSION_ONIG=6.9.3
ENV ONIG_BUILD_DIR=/tmp/oniguruma

RUN set -xe; \
    mkdir -p ${ONIG_BUILD_DIR}; \
    curl -Ls https://github.com/kkos/oniguruma/releases/download/v${VERSION_ONIG}/onig-${VERSION_ONIG}.tar.gz \
        | tar xzC ${ONIG_BUILD_DIR} --strip-components=1; \
    cd ${ONIG_BUILD_DIR}/; \
    ./configure; \
    make -j $(nproc); \
    make install

RUN set -xe; \
    mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/448c1cd0d58ba2838b9b6dff71c9b7e70a401b90.tar.gz \
        | tar xvz -C "/usr/src/php/ext/imagick" --strip-components=1;

RUN set -xe; \
    apt update; \
    apt install --yes \
        mariadb-client \
        git \
        zip unzip \
        curl \
        libzip-dev libcurl4-gnutls-dev libpng-dev libxml2-dev libjpeg-dev libfreetype6-dev \
        libmagickwand-dev; \
    curl -sL https://deb.nodesource.com/setup_12.x | bash -; \
    apt install -y nodejs; \
    docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/; \
    docker-php-ext-install pdo_mysql mysqli gd zip intl soap mbstring exif bcmath curl sockets; \
    docker-php-ext-install imagick; \
    docker-php-ext-enable imagick; \
    docker-php-ext-enable mysqli;

# RUN set -xe ; \
#     pecl install xdebug; \
#     docker-php-ext-enable xdebug
