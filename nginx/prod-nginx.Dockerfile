FROM nginx:latest
WORKDIR /app

RUN mkdir -p /etc/nginx

COPY . /etc/nginx/

RUN mkdir -p /etc/nginx/sites-enabled/ && \
    ln -s /etc/nginx/sites-available/example.com.conf /etc/nginx/sites-enabled/

RUN echo "<?php phpinfo(); ?>" > /app/index.php

EXPOSE 80 443
# CMD [ "/var/www/init-prod.sh" ]