# **************************************************************************** #
#                                                                              #
#         __ __         __    __  ___                                          #
#        / // /__ ____ / /   /  |/  /__  __ __                                 #
#       / _  / _ `/ -_) /   / /|_/ / _ \/ // /                                 #
#      /_//_/\_,_/\__/_/   /_/  /_/\___/\_,_/                                  #
#                                                                              #
#      | Redis Dockerfile                                                      #
#      | By: hael-mou <hamzaelmoudden2@gmail.com>                              #
#      | Created: 2024/03/07                                                   #
#                                                                              #
# **************************************************************************** #

FROM        alpine:3.19

RUN         set -xe && apk update\
            &&  apk add --no-cache redis\
            &&  rm -f /var/cache/apk/*;

COPY        config/redis.conf /etc/redis.conf

RUN         set -xe \
			&&  chown -R nobody:nobody /etc/redis.conf /var/run/ /var/log;

EXPOSE      6379

USER        nobody

CMD         ["redis-server", "/etc/redis.conf"]

HEALTHCHECK --interval=2s --timeout=40s --start-period=1s --retries=3\
        CMD netstat -tuln | grep LISTEN | grep 0.0.0.0:6379;