# **************************************************************************** #
#                                                                              #
#         __ __         __    __  ___                                          #
#        / // /__ ____ / /   /  |/  /__  __ __                                 #
#       / _  / _ `/ -_) /   / /|_/ / _ \/ // /                                 #
#      /_//_/\_,_/\__/_/   /_/  /_/\___/\_,_/                                  #
#                                                                              #
#      | Calculator Dockerfile                                                  #
#      | By: hael-mou <hamzaelmoudden2@gmail.com>                              #
#      | Created: 2024/02/22                                                   #
#                                                                              #
# **************************************************************************** #

FROM        alpine:3.19

RUN         set -xe \
            && apk update \
            && apk add --no-cache nodejs npm \
            && mkdir -p /var/www/Calculator \
            && npm init --prefix /var/www/Calculator -y \
            && npm install --prefix /var/www/Calculator express \
            && rm -rf /var/cache/apk/*;

COPY        config/  /var/www/Calculator/

WORKDIR     /var/www/Calculator

STOPSIGNAL  SIGKILL

EXPOSE      8081

CMD         [ "node", "server.js" ]
