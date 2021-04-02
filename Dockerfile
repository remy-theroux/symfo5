# the different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/compose/compose-file/#target

ARG PHP_VERSION=8.0
ARG NGINX_VERSION=1.19

FROM php:${PHP_VERSION}-fpm-alpine AS php-fpm

#COPY docker/php/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#
#RUN apk add --no-cache $PHPIZE_DEPS; \
#    pecl install xdebug-2.9.8; \
#    docker-php-ext-enable xdebug
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
#COPY docker/php/php.ini /usr/local/etc/php/php.ini
#COPY docker/php/php-cli.ini /usr/local/etc/php/php-cli.ini
#COPY docker/php/ext-geoip/GeoIP.dat /usr/share/GeoIP/GeoIP.dat
#COPY docker/php/php-fpm.conf /usr/local/etc/php-fpm.conf

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1
COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY . .
RUN set -eux; \
	composer install --prefer-dist --no-autoloader --no-scripts --no-progress --no-suggest;

RUN set -eux; \
	composer dump-autoload --classmap-authoritative; \
	chmod +x bin/console; sync;

VOLUME /var/www/var
VOLUME /var/www/public/assets

COPY docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]

CMD ["php-fpm"]

FROM nginx:${NGINX_VERSION}-alpine AS nginx

COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/nginx/conf.d/default.conf /etc/nginx/conf.d/

WORKDIR /var/www

COPY --from=php-fpm /var/www/public public/
