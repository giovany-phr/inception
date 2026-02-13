#!/bin/bash

sleep 10

# generate wp-config.php
wp config create    --path=/var/www/wordpress \
                    --dbhost="$WP_HOST" \
                    --dbprefix="wp_" \
                    --dbname="$WP_NAME" \
                    --dbuser="$WP_USER" \
                    --dbpass="$WP_USER_PASSWORD" \
                    --allow-root

# install wordpress with DB
wp core install     --path=/var/www/wordpress \
                    --url="$WP_DOMAIN" \
                    --title="$WP_NAME" \
                    --admin_name="$WP_ADMIN" \
                    --admin_password="$WP_ADMIN_PASSWORD" \
                    --admin_email="$WP_ADMIN_MAIL" \
                    --skip-email \
                    --allow-root

# create a user with author role
wp user create      "$USER_NAME" "$USER_MAIL" \
                    --user_pass="$USER_PASSWORD" \
                    --role=author \
                    --allow-root \
                    --path=/var/www/wordpress

# starts PHP-FPM in -F foreground mode
# nginx can interprete .php
exec /usr/sbin/php-fpm7.4 -F

