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


RUN 	    apk update && \
    	    apk add --no-cache nginx openssl libcap &&\
		    rm -f /var/cache/apk/*

RUN         setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx &&\
            mkdir /etc/nginx/ssl &&\
            chown -R nginx:nginx /etc/nginx

COPY        ./config/nginx.conf   /etc/nginx/nginx.conf

USER        nginx

RUN         openssl req -x509 -nodes -newkey rsa:2048\
                -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt\
		        -subj "/C=MR/ST=Tangier_Tetouan_Al Hoceima/L=Tetouan/O=42/OU=1337\
	        	/CN=hael-mou.42.fr"

EXPOSE      443/tcp

CMD	        ["nginx", "-g", "daemon off;"]