#!/bin/sh

set -e &&\

if [ ! -d "/var/www/html/adminer" ]; then

        mkdir -p /var/www/html/adminer;
        mv -f /entrypoint/index.php /var/www/html/adminer
fi;
exec $@;