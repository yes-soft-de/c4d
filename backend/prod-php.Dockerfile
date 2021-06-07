FROM composer:latest as composer
FROM php:fpm
WORKDIR /var/www

# Enabeling PHP exts
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-configure gd && docker-php-ext-install gd

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# Saving build stages, These get cached!
COPY composer.json composer.json
COPY composer.lock composer.lock
RUN composer install

# Install the actual backend
COPY . .

# Expose for ... reasons
EXPOSE 9000
CMD [ "init-prod.sh" ]