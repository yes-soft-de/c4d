FROM nginx:latest
WORKDIR /var/www

COPY . /etc/nginx/

EXPOSE 80 443
# CMD [ "/var/www/init-prod.sh" ]