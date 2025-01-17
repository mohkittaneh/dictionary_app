FROM php:8.1-apache

RUN docker-php-ext-install mysqli


RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

COPY . /var/www/html/


WORKDIR /var/www/html/


EXPOSE 80

CMD ["apache2-foreground"
