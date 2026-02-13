#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

#temporarily starts mariadb in background 
mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &

sleep 2

mysql -uroot -p"$SQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$SQL_DATABASE\`;"
mysql -uroot -p"$SQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';"
mysql -uroot -p"$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';"
mysql -uroot -p"$SQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"
mysql -uroot -p"$SQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

sleep 5;

mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

#replaces script by last CMD for better signal process managment
exec "$@";