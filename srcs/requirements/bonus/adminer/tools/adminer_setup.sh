#!/bin/sh

set -e &&\

if [ ! -d "/var/www/html/adminer" ]; then

        mkdir -p /var/www/html/adminer;
        chmod -R 775 /var/www/html/adminer 2>/dev/null || echo "chmod error !!";
        mv -f /entrypoint/index.php /var/www/html/adminer;
fi;
exec $@;