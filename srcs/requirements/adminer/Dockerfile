# **************************************************************************** #
#                                                                              #
#         __ __         __    __  ___                                          #
#        / // /__ ____ / /   /  |/  /__  __ __                                 #
#       / _  / _ `/ -_) /   / /|_/ / _ \/ // /                                 #
#      /_//_/\_,_/\__/_/   /_/  /_/\___/\_,_/                                  #
#                                                                              #
#      | Wordpress Dockerfile                                                  #
#      | By: hael-mou <hamzaelmoudden2@gmail.com>                              #
#      | Created: 2024/02/27                                                   #
#                                                                              #
# **************************************************************************** #

FROM        alpine:3.19

RUN         set -xe && apk update\
            &&  apk add --no-cache php82 php82-fpm php82-mysqli php82-session\
            &&  rm -f /var/cache/apk/*;

COPY        config/ tools/   entrypoint/

RUN         set -xe \
            &&   wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php\
                -O /entrypoint/index.php && mkdir -p /var/www/html\
            &&  mv -f /entrypoint/00_custom.ini /etc/php82/conf.d/\
            &&  mv -f /entrypoint/www.conf /etc/php82/php-fpm.d/\
			&&  chown -R nobody:nobody /etc/php82 /var/www/html /entrypoint /var/log\
            &&  chmod -R +x /entrypoint;

EXPOSE      9000

USER        nobody

ENTRYPOINT  [ "entrypoint/adminer_setup.sh" ]
CMD         ["php-fpm82", "-F"]

HEALTHCHECK --interval=2s --timeout=40s --start-period=2s --retries=3\
        CMD netstat -tuln | grep LISTEN | grep 0.0.0.0:9000;