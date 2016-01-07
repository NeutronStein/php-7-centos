#!/bin/bash
cd $HOME

# Create a dir for storing PHP module conf
mkdir /usr/local/php7/etc/conf.d

# Symlink php-fpm to php7-fpm
ln -s /usr/local/php7/sbin/php-fpm /usr/local/bin/php7-fpm
ln -s /usr/local/php7/bin/php /usr/local/bin/php
ln -s /usr/local/php7/bin/phpize /usr/local/bin/phpize

# Add config files
cp php-src/php.ini-production /usr/local/php7/lib/php.ini

cd $HOME/php-7-centos
cp conf/www.conf /usr/local/php7/etc/php-fpm.d/www.conf
cp conf/php-fpm.conf /usr/local/php7/etc/php-fpm.conf
cp conf/modules.ini /usr/local/php7/etc/conf.d/modules.ini

# Add the init script
cp conf/php7-fpm.service /lib/systemd/system/php7-fpm.service

groupadd www-data
useradd -g www-data www-data

sudo systemctl start php7-fpm
sudo systemctl enable php7-fpm