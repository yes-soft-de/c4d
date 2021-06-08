FROM nginx:latest
WORKDIR /var/www

RUN mkdir -p /etc/nginx

COPY . /etc/nginx/

EXPOSE 80 443
# CMD [ "/var/www/init-prod.sh" ]