FROM php:7.4-apache-bullseye

LABEL maintainer="mikep@locol.media"  

ARG UPLOAD_SIZE=8M
ARG APACHE_SERVER_ADMIN
ARG WORDPRESS_FILES

ENV APACHE_SERVER_ADMIN=${APACHE_SERVER_ADMIN}
ENV APACHE_DOCUMENT_ROOT=/var/www/html

RUN a2enmod rewrite expires remoteip 

# install the PHP extensions we need
RUN apt-get update && apt-get install --no-install-recommends -y msmtp less mariadb-client libfreetype6-dev libpng-dev libwebp-dev libjpeg-dev libmagickwand-dev libzip-dev tcpdump nano \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j "$(nproc)" bcmath exif gd mysqli opcache zip

RUN pecl install imagick-3.4.4 \
    && docker-php-ext-enable imagick

RUN  echo 'upload_max_filesize = $UPLOAD_SIZE' >> /usr/local/etc/php/conf.d/upload.ini
COPY build-php /usr/local/etc/php/conf.d/
COPY build-apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY build-apache2/ports.conf /etc/apache2/ports.conf

COPY $WORDPRESS_FILES /var/www/html 

RUN mkdir -p /tmp/opcache \
    && chown -R www-data:www-data /tmp/opcache \
    && chown -R www-data:www-data /var/www/html/wp-content/uploads \
    && : > wp-content/debug.log 


### WP-CLI
RUN curl -SL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp




USER www-data
CMD apache2-foreground

EXPOSE 8080