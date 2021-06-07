FROM composer:latest as composer
FROM php:7.4.20-fpm
WORKDIR /var/www

# Enabeling PHP exts
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# Saving build stages, These get cached!
COPY composer.json composer.json
RUN composer install

# Install the actual backend
COPY . .

RUN chmod +x ./init-prod.sh

# Expose for ... reasons
EXPOSE 9000
CMD [ "/var/www/init-prod.sh", "php-fpm" ]