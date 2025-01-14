FROM php:7.4-apache

# copy config file
COPY ./docker-dev/php/php.ini /usr/local/etc/php/
COPY ./docker-dev/apache/*.conf /etc/apache2/sites-enabled/

# module install
RUN apt-get update\
  && apt-get install -y libfreetype6-dev libonig-dev libjpeg62-turbo-dev libpng-dev git vim unzip tree jq \
  && docker-php-ext-install pdo_mysql mysqli gd \
  && apt-get clean

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# mods rewrite の有効か
RUN a2enmod rewrite