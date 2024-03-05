# **************************************************************************** #
#                                                                              #
#         __ __         __    __  ___                                          #
#        / // /__ ____ / /   /  |/  /__  __ __                                 #
#       / _  / _ `/ -_) /   / /|_/ / _ \/ // /                                 #
#      /_//_/\_,_/\__/_/   /_/  /_/\___/\_,_/                                  #
#                                                                              #
#      | mariadb Dockerfile                                                    #
#      | By: hael-mou <hamzaelmoudden2@gmail.com>                              #
#      | Created: 2024/02/22                                                   #
#                                                                              #
# **************************************************************************** #

FROM        alpine:3.19

RUN         set -xe \
            &&  apk update && apk add --no-cache mariadb mariadb-client\
            &&  rm -rf /var/cache/apk/*;

COPY        config/ tools/      script/

RUN         set -xe \
            &&  mv -f script/mariadb-server.cnf etc/my.cnf.d/mariadb-server.cnf\
            &&  mkdir -p /run/mysqld /var/log/mysql/ /var/lib/mysql/\
            &&  chown -R mysql:mysql /run/mysqld /var/log/ /etc/my.cnf\
            &&  chown -R mysql:mysql /etc/my.cnf.d /var/lib/mysql/ /script\
            &&  chmod -R +x /script;

EXPOSE      3306

USER        mysql

ENTRYPOINT  [ "/script/create_db.sh" ]
CMD         [ "/usr/bin/mysqld", "--console" ]

HEALTHCHECK --interval=2s --timeout=40s --start-period=2s --retries=3\
        CMD /script/healthcheck.sh