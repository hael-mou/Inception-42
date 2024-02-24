#!/bin/sh

set -e;
DATABASE_NAME=${DATABASE_NAME:-"wordpress"};
DATABASE_USR=${DATABASE_USR:-"db_user"};

mkdir -p /run/mysqld;
chown -R mysql:mysql /run/mysqld;

if [ ! -d "/var/lib/mysql/mysql" ]; then
    
    echo -n " # INIT MARIADB-SERVER ....";
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql \
                     --group=mysql --skip-test-db --rpm > /dev/null;
    echo -e "\033[1;32m ok \033[0m";
    
fi

chown -R mysql:mysql /var/lib/mysql;

if [ ! -d "/var/lib/mysql/$DATABASE_NAME" ]; then

    if [ "$MYSQL_ROOT_PWD" = "" ]; then
        MYSQL_ROOT_PWD=`pwgen 16 1`;
        echo -e "\033[1;33m[i] root Password: $MYSQL_ROOT_PWD\033[0m";
    fi

    if [ "$DATABASE_USR_PWD" = "" ]; then
        DATABASE_USR_PWD=`pwgen 16 1`;
        echo -e "\033[1;33m[i] user \"$DATABASE_USR\" Password: $DATABASE_USR_PWD\033[0m";
    fi

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
fi
