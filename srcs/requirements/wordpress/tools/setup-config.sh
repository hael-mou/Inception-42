#!/bin/sh

rm   -rf /entrypoint/done.wp

set -e &&\
if [ ! -d "/var/www/html/wordpress" ]; then

        echo -e "\033[1;32m-> download wordpress ...\033[0m";
        mkdir /var/www/html/wordpress && cd /var/www/html/wordpress;
        wp core download --version=6.4.3 --force --insecure --extract;
fi &&\

cd /var/www/html/wordpress &&\

if [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then

        echo -e "\033[1;32m-> Create wp-config.php ...\033[0m";
        wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_USER_PWD\
                --dbhost=$DB_HOST:$DB_PORT --force;
fi &&\

if [  -f "/var/www/html/wordpress/wp-config-sample.php" ]; then
        
        echo -e "\033[1;32m-> Install Content ...\033[0m";
        wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN\
                --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL;
        rm -rf /var/www/html/wordpress/wp-config-sample.php
fi;

mkdir   -p /entrypoint/done.wp

echo    -e "\033[1;32m-> start php-fmp sevice ...\033[0m";
exec $@;