# **************************************************************************** #
#                                                                              #
#         __ __         __    __  ___                                          #
#        / // /__ ____ / /   /  |/  /__  __ __                                 #
#       / _  / _ `/ -_) /   / /|_/ / _ \/ // /                                 #
#      /_//_/\_,_/\__/_/   /_/  /_/\___/\_,_/                                  #
#                                                                              #
#      | Nginx Dockerfile                                                      #
#      | By: hael-mou <hamzaelmoudden2@gmail.com>                              #
#      | Created: 2024/02/21                                                   #
#                                                                              #
# **************************************************************************** #

FROM        alpine:3.19

RUN 	    set -xe \
            &&  apk update && apk add --no-cache nginx libcap\
            &&  rm -rf /var/cache/apk/*;

COPY        ./      /tmp/

RUN         set -xe \
            &&  setcap  'cap_net_bind_service=+ep' /usr/sbin/nginx\
            &&  mv -f /tmp/config/nginx.conf /etc/nginx/nginx.conf\
            &&  mv -f /tmp/tools /etc/nginx/ssl\
            &&  chown -R nginx:nginx /etc/nginx /var/run/nginx/\
            &&  chown -R nginx:nginx /var/lib/nginx /var/log\
            &&  rm -rf /var/www/*\
            &&  mkdir -p /var/www/html\
            &&  chown -R nobody:nobody /var/www/html && adduser nginx nobody\
            &&  rm -rf /tmp/*;

EXPOSE      443

USER        nginx

ENTRYPOINT  [ "nginx" ]
CMD         ["-g", "daemon off;"]