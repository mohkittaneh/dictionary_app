FROM php:8.1-apache

RUN docker-php-ext-install mysqli

RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

COPY . /var/www/html/dictionary_app/

WORKDIR /var/www/html/dictionary_app/

EXPOSE 80

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN sed -i 's|/var/www/html|/var/www/html/dictionary_app|' /etc/apache2/sites-available/000-default.conf

CMD ["apache2-foreground"]
