#!/bin/sh

set -e

# Remove previous setup files
rm -rf /entrypoint/done.wp

# Define variables
WP_PATH="/var/www/html/wordpress"

# Download WordPress if not already present
if [ ! -d "$WP_PATH" ]; then
    echo -e "\033[1;32m-> Downloading WordPress...\033[0m"
    mkdir -p "$WP_PATH" && cd "$WP_PATH"
    wp core download --version=6.4.3 --force --insecure --extract
fi

# Create wp-config.php if not already present
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo -e "\033[1;32m-> Creating wp-config.php...\033[0m"
    wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_USER_PWD" \
        --dbhost="$DB_HOST:$DB_PORT" --force
fi

# Install WordPress if not already installed
if [ -f "$WP_PATH/wp-config-sample.php" ]; then
    echo -e "\033[1;32m-> Installing WordPress Content...\033[0m"
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL"
    wp user create "$WP_USER" "$WP_USER_EMAIL" --role="$WP_USER_ROLE" --user_pass="$WP_USER_PWD"
    rm -rf "$WP_PATH/wp-config-sample.php"
fi

# Install a WordPress theme
if ! $(wp theme is-installed astra); then
    echo -e "\033[1;32m-> Installing WordPress Theme: generatepress...\033[0m"
    wp theme install generatepress --activate
fi

# Install and configure Redis Object Cache plugin
if ! $(wp plugin is-active wp-redis); then
    echo -e "\033[1;32m-> Installing Redis Object Cache plugin...\033[0m"
    wp plugin install redis-cache --activate
    wp config set WP_REDIS_HOST "redis"
    wp config set WP_REDIS_PORT "6379"
    wp config set WP_REDIS_DATABASE "0"
fi


wp redis enable;

# Create marker file indicating setup completion
mkdir -p /entrypoint/done.wp

echo -e "\033[1;32m-> Starting php-fpm service...\033[0m"
exec "$@"