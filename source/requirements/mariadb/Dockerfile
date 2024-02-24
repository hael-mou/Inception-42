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

# # Base image alpine:3.19 :
FROM        alpine:3.19

# # Install Necessary Packages : mariadb-server, mariadb-client
RUN         set -xe &&\
            apk update  &&\
            apk add --no-cache mariadb mariadb-client &&\
            rm -rf /var/cache/apk/*;

# # Copy Configuration & Tools Files :
COPY        config/ tools/      /entrypoint/

# # Init Mariadb && Set Config :
RUN         /entrypoint/init_server.sh

# # Expose Ports :
EXPOSE      3306

# # Set User To Mysql :
USER        mysql

# # Set Entrypoint To Start Mariadb Server :
ENTRYPOINT [ "/entrypoint/setup_database.sh" ]
CMD        [ "/usr/bin/mysqld", "--console" ]