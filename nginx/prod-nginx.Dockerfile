FROM nginx:latest

COPY . /etc/nginx/

EXPOSE 80 443
CMD [ "init-prod.sh" ]