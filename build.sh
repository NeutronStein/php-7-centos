#!/bin/bash
cd $HOME

# Dependencies
sudo yum update -y
sudo yum install -y epel-release
sudo yum groupinstall -y "Development Tools"
sudo yum install -y \
    libxml2-devel \
    bzip2-devel \
    libmcrypt-devel \
    libicu-devel \
    openssl-devel \
    libtool-ltdl-devel \
    libjpeg-turbo-devel \
    libpng-devel \
    aspell-devel \
    readline-devel \
    libcurl-devel

sudo mkdir /usr/local/php7

git clone https://github.com/php/php-src.git
cd php-src
git checkout PHP-7.0.2
git pull
./buildconf --force

CONFIGURE_STRING="--prefix=/usr/local/php7 \
                  --with-config-file-scan-dir=/usr/local/php7/etc/conf.d \
                  --without-pear \
                  --enable-bcmath \
                  --with-bz2 \
                  --enable-calendar \
                  --enable-intl \
                  --enable-exif \
                  --enable-dba \
                  --enable-ftp \
                  --with-gettext \
                  --with-gd \
                  --with-jpeg-dir \
                  --enable-mbstring \
                  --with-mcrypt \
                  --with-mhash \
                  --enable-mysqlnd \
                  --with-mysql-sock=/var/run/mysqld/mysqld.sock \
                  --with-mysqli=mysqlnd \
                  --with-pdo-mysql=mysqlnd \
                  --with-openssl \
                  --enable-pcntl \
                  --with-pspell \
                  --enable-shmop \
                  --enable-soap \
                  --enable-sockets \
                  --enable-sysvmsg \
                  --enable-sysvsem \
                  --enable-sysvshm \
                  --enable-wddx \
                  --with-zlib \
                  --enable-zip \
                  --with-readline \
                  --with-curl \
                  --enable-fpm \
                  --with-fpm-user=www-data \
                  --with-fpm-group=www-data"

./configure $CONFIGURE_STRING

make
sudo make install
