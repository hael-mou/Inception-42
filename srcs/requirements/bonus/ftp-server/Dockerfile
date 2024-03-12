# **************************************************************************** #
#                                                                              #
#         __ __         __    __  ___                                          #
#        / // /__ ____ / /   /  |/  /__  __ __                                 #
#       / _  / _ `/ -_) /   / /|_/ / _ \/ // /                                 #
#      /_//_/\_,_/\__/_/   /_/  /_/\___/\_,_/                                  #
#                                                                              #
#      | ftp-server Dockerfile                                                 #
#      | By: hael-mou <hamzaelmoudden2@gmail.com>                              #
#      | Created: 2024/03/12                                                   #
#                                                                              #
# **************************************************************************** #

FROM        alpine:3.19

ARG         FTP_USR
ARG         FTP_PWD

RUN         set -xe && apk update\
            &&  apk add --no-cache vsftpd\
            &&  rm -f /var/cache/apk/*;

COPY        config/vsftpd.conf  /etc/vsftpd/vsftpd.conf

RUN         set -xe\
            &&  mkdir -p /var/www/html && chmod -R 775 /var/www/html\
            &&  adduser $FTP_USR --disabled-password\
            &&  echo "$FTP_USR:$FTP_PWD" | /usr/sbin/chpasswd\
            &&  echo $FTP_USR | tee -a /etc/vsftpd.userlist\
            &&  chown -R nobody:nobody /var/www/html\
            &&  adduser $FTP_USR nobody;

WORKDIR     /var/www/html

STOPSIGNAL  SIGKILL

ENTRYPOINT  [ "vsftpd", "/etc/vsftpd/vsftpd.conf" ]