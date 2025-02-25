FROM php:8.0-fpm

RUN apt-get update && apt-get install -y  \
    libmagickwand-dev \
    --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install pdo_mysql

# Install Xdebug

RUN pecl install xdebug && docker-php-ext-enable xdebug

# Configure Xdebug in php.ini
RUN echo "zend_extension=xdebug" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_host=host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_port=9003" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN echo "xdebug.remote_autostart = 1" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.profiler_enable_trigger = 1" >> /usr/local/etc/php/conf.d/xdebug.ini

# Expose the PHP FPM port

EXPOSE 9000 9003
