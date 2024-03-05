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
            &&  apk add --no-cache curl php82 php82-fpm php82-cli php82-json\
                php82-gd php82-openssl php82-mbstring php82-curl php82-xmlwriter\
                php82-dom php82-mysqli php82-xml php82-zlib php-zip php82-simplexml\
                php82-posix php82-pdo_mysql php82-session php82-tokenizer php82-xmlreader\
                php82-fileinfo php82-iconv php82-mysqlnd php82-phar\
            &&  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
            &&  chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp\
            &&  rm -f /var/cache/apk/*;

COPY        config/ tools/   entrypoint/

RUN         set -xe \
			&&  mkdir -p /.wp-cli /var/www/html\
            &&  mv -f /entrypoint/00_custom.ini /etc/php82/conf.d/\
            &&  mv -f /entrypoint/www.conf /etc/php82/php-fpm.d/\
			&&  chown -R nobody:nobody /etc/php82 /var/www/html /.wp-cli /entrypoint /var/log\
            &&  chmod -R +x /entrypoint;

EXPOSE      9000

USER        nobody

ENTRYPOINT  [ "entrypoint/setup-config.sh" ]
CMD         ["php-fpm82", "-F"]

HEALTHCHECK --interval=2s --timeout=40s --start-period=2s --retries=3\
        CMD /entrypoint/healthcheck.sh