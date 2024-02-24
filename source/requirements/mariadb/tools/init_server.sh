#!/bin/sh

DEF="\033[0m";
GREEN="\033[1;32m";

set -e &&\
echo -n " # INIT MARIADB-SERVER ...." &&\

mkdir -p /run/mysqld &&\
chown -R mysql:mysql /run/mysqld &&\

if [ ! -d "/var/lib/mysql/mysql" ]; then

    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql\
                     --group=mysql --skip-test-db --rpm > /dev/null;
fi &&\

mv -f /entrypoint/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf &&\
chown -R mysql:mysql /etc/my.cnf /etc/my.cnf.d &&\
chmod -R 644 /etc/my.cnf /etc/my.cnf.d &&\

echo -e "$GREEN ok.$DEF" &&\
rm -rf /entrypoint/init_server.sh;
