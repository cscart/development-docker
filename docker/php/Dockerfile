ARG PHP_VERSION
FROM searchanise/php:${PHP_VERSION}-fpm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -; \
    apt install -y nodejs;
COPY image-files/ /
ENTRYPOINT cs-cart-entrypoint.php