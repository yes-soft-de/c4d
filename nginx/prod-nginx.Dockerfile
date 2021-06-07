FROM nginx:latest
WORKDIR /var/www

COPY . /etc/nginx/

COPY init-prod.sh init-prod.sh
RUN chmod +x init-prod.sh

EXPOSE 80 443
CMD [ "/var/www/init-prod.sh" ]