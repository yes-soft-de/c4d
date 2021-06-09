#!/bin/bash

# Salute
echo "Hello From FPM"

# Write private and public pem keys
mkdir -p config/jwt
echo "$PRIVATE_PEM" | base64 --decode > config/jwt/private.pem
echo "$PUBLIC_PEM" | base64 --decode > config/jwt/public.pem

######################### End Keys Creation #########################

# Write .env file
echo "APP_ENV=dev" > .env
echo "APP_SECRET=c495ab23a840189035a176258ba53b64" >> .env
echo "DATABASE_URL=mysql://root:$MYSQL_PASSWORD@c4d-mysql:3306/c4d-mysql?serverVersion=5" >> .env

echo "JWT_SECRET_KEY=%kernel.project_dir%/config/jwt/private.pem" >> .env
echo "JWT_PUBLIC_KEY=%kernel.project_dir%/config/jwt/public.pem" >> .env
echo "JWT_PASSPHRASE=$PASSPHRASE" >> .env

# TODO: Change this when the domain is ready
echo "CORS_ALLOW_ORIGIN=*" >> .env

echo "SITE_BASE_URL=https://localhost:8000" >> .env
echo "IMAGE_FOLDER=image" >> .env
echo "ORIGINAL_IMAGE=original-image" >> .env

echo "LOCK_DSN=semaphore" >> .env
echo "MAILER_DSN=smtp://c938d7632db211:d6a130d7401a0a@smtp.mailtrap.io:2525" >> .env

######################### End Env Creation #########################

################## Copy the project to the PVC #####################
mkdir -p /var/www/upload

# Starting the FPM Process
php-fpm