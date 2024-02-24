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

# Install necessary packages :
RUN         apk update;\
            apk add --no-cache mariadb mariadb-client pwgen;\
            rm -rf /var/cache/apk/*;

# Copy necessary configuration files :
COPY        config/* /config/

# Run database initialization script :
RUN         ./config/create_database.sh;\
            mv -f /config/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf;\
            chown -R mysql:mysql /etc/my.cnf.d;\
            rm -rf /config /tmp/*;

# Expose ports :
EXPOSE      3306

# Set user to mysql :
USER        mysql

# Set entrypoint to start MySQL server :
ENTRYPOINT [ "/usr/bin/mysqld", "--console" ]