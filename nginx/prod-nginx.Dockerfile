FROM nginx:latest
WORKDIR /var/www

RUN mkdir -p /etc/nginx

COPY . /etc/nginx/

RUN mkdir -p /etc/nginx/sites-enabled/ && \
    ln -s /etc/nginx/sites-available/example.com.conf /etc/nginx/sites-enabled/

EXPOSE 80 443
# CMD [ "/var/www/init-prod.sh" ]