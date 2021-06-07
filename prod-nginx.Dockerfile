FROM nginx:latest
WORKDIR /var/www

RUN mkdir -p /etc/nginx

COPY ./nginx/ /etc/nginx/

COPY ./backend/ /var/www/

EXPOSE 80 443
# CMD [ "/var/www/init-prod.sh" ]