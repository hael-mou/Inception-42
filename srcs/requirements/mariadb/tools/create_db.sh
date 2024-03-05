#!/bin/sh

rm   -rf /script/done.wp

set -e &&\
# # INSTALL MARIADB DB ... :
if [ ! -d "/var/lib/mysql/mysql" ]; then

	echo -e "\033[1;32m-> INSTALL MARIADB DB ...\033[0m";
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql\
		--group=mysql --skip-test-db --rpm; 
fi &&\

# # CREATE USER & DATABASE ... : 
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

	echo -e "\033[1;32m-> CREATE USER & DATABASE ...\033[0m";
	/usr/bin/mysqld --bootstrap << EOF
        USE mysql;
        FLUSH PRIVILEGES;

        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.db WHERE Db='test';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

        ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';

        CREATE DATABASE $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
        CREATE USER '$DB_USER'@'%' IDENTIFIED by '$DB_USER_PWD';
        GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
        DROP USER 'mysql'@'localhost';
        FLUSH PRIVILEGES;
EOF
fi;

mkdir   -p /script/done.wp

echo    -e "\033[1;32m-> start mariadb sevice ...\033[0m";
exec $@;
