FROM php:apache
MAINTAINER DACRepair@gmail.com

# Start
RUN apt-get update

# Install GIT
RUN apt-get -y install git

# Install GD
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Install APCu
RUN pecl install apcu
RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini

# Install MySQLi
RUN docker-php-ext-install mysqli

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Cachet
RUN git clone https://github.com/cachethq/Cachet.git /var/www/html

RUN a2enmod rewrite

EXPOSE 80
CMD ["apache2-foreground"]
