ARG PHP_VERSION=5.6.36
FROM protopopys/docker-php:${PHP_VERSION}-fpm-alpine3.7
LABEL maintainer="Protopopys <protopopys@gmail.com>"
ENV PHPIZE_DEPS \
    coreutils \
	autoconf \
	dpkg-dev dpkg \
	file \
	g++ \
	gcc \
	libc-dev \
	make \
	pkgconf \
	re2c
RUN set -xe; \
    apk add --no-cache --update --virtual .build-deps \
	${PHPIZE_DEPS} \
#icu for intl
    icu-dev \
#zlib for zip
    zlib-dev \
#for xml
    libxml2-dev \
#imagick
    imagemagick6-dev; \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1); \
    docker-php-ext-install -j${NPROC} \
    exif \
    intl \
    mysqli \
    mbstring \
    zip \
    soap \
 && pecl channel-update pecl.php.net \
 && pecl install imagick \
 && pecl install apcu-4.0.11 \
 && docker-php-ext-enable imagick apcu \
 && echo -e 'file_uploads = On\n\
memory_limit = 256M\n\
upload_max_filesize = 250M\n\
post_max_size = 250M\n\
max_execution_time = 600'\
>> /usr/local/etc/php/conf.d/docker-php-uploads.ini \
 && runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
 && apk add --no-cache --virtual .php-rundeps $runDeps \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/cache/apk/*  ~/.pearrc