FROM php:7.4-fpm AS vendor
WORKDIR /tmp/
COPY composer.json composer.json
COPY composer.lock composer.lock
RUN apt update -y && apt install zip -y && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN  composer update 
RUN composer update symfony/flex --no-plugins --no-scripts

RUN composer install
RUN composer require symfony/translation && composer require doctrine/annotations && composer require symfony/orm-pack

FROM php:7.4-apache
RUN apt-get update && apt-get install -y build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY --chown=www-data:www-data . /var/www/html
RUN a2enmod rewrite
COPY --from=gcr.io/pc-api-6479467557629758909-343/c4dsec ./.env /var/www/html
RUN apt update -y && apt install zip -y && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer update symfony/flex --no-plugins --no-scripts

#RUN composer dump-env prod
COPY --from=gcr.io/pc-api-6479467557629758909-343/c4dsec ./.htaccess /var/www/html/public
COPY --from=gcr.io/pc-api-6479467557629758909-343/c4dsec ./jwt/ /var/www/html/config/jwt
COPY --from=gcr.io/pc-api-6479467557629758909-343/c4dsec ./c4d-app-c299b-firebase-adminsdk-xegik-fa885c59c0.json /var/www/html/config/
RUN chown -R www-data:www-data /var && chmod -R g+rw /var
COPY --from=vendor /tmp/vendor/ /var/www/html/vendor/
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-configure gd && docker-php-ext-install gd
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
RUN php bin/console cache:clear
RUN chmod  +x ./entrypoint.sh 
CMD ["./entrypoint.sh"]
