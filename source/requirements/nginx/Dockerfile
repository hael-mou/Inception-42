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

# # Base image alpine:3.19 :
FROM        alpine:3.19

# Install necessary packages : nginx - libcap
RUN 	    apk update;\
            apk add --no-cache nginx libcap;\
            rm -f /var/cache/apk/*;

# # Copy necessary configuration files :
COPY        ./    /tmp/

# # setup nginx config, ssl keys, and bind permissions :
RUN         set -xe &&\
            setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx &&\
            mv -f /tmp/tools /etc/nginx/ssl &&\
            mv -f /tmp/config/nginx.conf /etc/nginx/nginx.conf &&\
            chown -R nginx:nginx /etc/nginx &&\
            rm -rf /tmp/*;

# # Expose service ports :
EXPOSE      443/tcp

# # Set user to nginx :
USER        nginx

# # Set entrypoint to start nginx server :
ENTRYPOINT  [ "nginx" ]
CMD         ["-g", "daemon off;"]