FROM debian:bullseye

RUN     apt update -y && apt upgrade -y

RUN     apt-get install -y php7.4\
        php-fpm\
        php-mysql\
        wget\
        mariadb-client

RUN     wget https://fr.wordpress.org/wordpress-6.8-fr_FR.tar.gz -P /var/www
RUN     cd /var/www && tar -xzf wordpress-6.8-fr_FR.tar.gz && rm wordpress-6.8-fr_FR.tar.gz

#wordpress gets root ownership
RUN     chmod 755 /var/www/wordpress
RUN     chown -R root:root /var/www/wordpress

RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN     chmod +x wp-cli.phar

#in bin to make wp globally executable
RUN     mv wp-cli.phar /usr/local/bin/wp

COPY    ./conf/www.conf /etc/php/7.4/fpm/pool.d

COPY    ./tools/script.sh .
RUN     chmod +x script.sh

#PHP-FPM file to stock socket Unix and runtime file
RUN     mkdir -p /var/run/php

EXPOSE  9000

CMD     ["./script.sh"]


