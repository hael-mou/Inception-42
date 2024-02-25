#!/bin/sh

DATABASE_NAME=${DATABASE_NAME:-"wordpress"};
MARIADB_USER=${MARIADB_USER:-"db_user"};
MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD:-"root4root"};
MARIADB_USER_PASSWORD=${MARIADB_USER_PASSWORD:-"user4user"};

set -e &&\

if [ ! -d "/var/lib/mysql/$DATABASE_NAME" ]; then

    echo -n " # CREATE USER & DATABASE ...";   
    /usr/bin/mysqld --user=mysql --bootstrap << EOF &> /dev/null;
        USE mysql;
        FLUSH PRIVILEGES;

        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.db WHERE Db='test';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

        ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';

        CREATE DATABASE $DATABASE_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
        CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_USER_PASSWORD';
        GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$MARIADB_USER'@'%';
        FLUSH PRIVILEGES;
EOF
        echo -e "\033[1;32m ok \033[0m";
fi &&\

unset DATABASE_NAME MARIADB_USER MARIADB_ROOT_PASSWORD MARIADB_USER_PASSWORD;
exec $@;
