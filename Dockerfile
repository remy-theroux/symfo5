FROM php:8.0-fpm-alpine

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY --from=wizbii/caddy /caddy /usr/local/bin/caddy

RUN apk add --no-cache autoconf openssl-dev g++ make pcre-dev icu-dev zlib-dev libzip-dev && \
    docker-php-ext-install bcmath intl opcache zip sockets && \
    apk del --purge autoconf g++ make && \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

WORKDIR /usr/src/app

COPY composer.json composer.lock ./

RUN composer install --no-dev --optimize-autoloader --no-scripts --no-plugins --prefer-dist --no-progress --no-interaction

COPY . .

ENV APP_ENV=prod
ENV PORT=80

RUN caddy -validate -conf=docker/Caddyfile && \
    cp docker/php-fpm.conf /usr/local/etc/php-fpm.d/zz-docker.conf && \
    php bin/console cache:warmup && \
    chmod -R 777 var/cache var/log

EXPOSE 80

CMD ["caddy", "--conf", "docker/Caddyfile", "--log", "stdout"]
