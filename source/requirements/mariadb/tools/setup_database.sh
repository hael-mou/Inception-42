#!/bin/sh

DATABASE_NAME=${DATABASE_NAME:-"wordpress"};
DATABASE_USR=${DATABASE_USR:-"db_user"};
MYSQL_ROOT_PWD=${MYSQL_ROOT_PWD:-"root4root"};
DATABASE_USR_PWD=${DATABASE_USR_PWD:-"user4user"};

set -e &&\

if [ ! -d "/var/lib/mysql/$DATABASE_NAME" ]; then

    echo -n " # CREATE USER & DATABASE ...";   
    /usr/bin/mysqld --user=mysql --bootstrap << EOF &> /dev/null;
        USE mysql;
        FLUSH PRIVILEGES;

        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.db WHERE Db='test';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

        ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';

        CREATE DATABASE $DATABASE_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
        CREATE USER '$DATABASE_USR'@'%' IDENTIFIED by '$DATABASE_USR_PWD';
        GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USR'@'%';
        FLUSH PRIVILEGES;
EOF
        echo -e "\033[1;32m ok \033[0m";
fi &&\

unset DATABASE_NAME DATABASE_USR MYSQL_ROOT_PWD DATABASE_USR_PWD;
exec $@;
