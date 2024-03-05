#!/bin/sh

while [ ! -d "/script/done.wp" ]; do
    sleep 1
done

mariadb -P$DB_PORT -u$DB_USER -p$DB_USER_PWD -D$DB_NAME >/dev/null;