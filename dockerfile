FROM php:8.1-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli

# Install Node.js and npm
RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Copy application files
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html/

# Expose port 80 for Apache
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]

