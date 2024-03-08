# **************************************************************************** #
#                                                                              #
#         __ __         __    __  ___                                          #
#        / // /__ ____ / /   /  |/  /__  __ __                                 #
#       / _  / _ `/ -_) /   / /|_/ / _ \/ // /                                 #
#      /_//_/\_,_/\__/_/   /_/  /_/\___/\_,_/                                  #
#                                                                              #
#      | Adminer Dockerfile                                                    #
#      | By: hael-mou <hamzaelmoudden2@gmail.com>                              #
#      | Created: 2024/03/08                                                   #
#                                                                              #
# **************************************************************************** #

FROM    alpine:3.19

RUN     set -xe && apk update\
        &&  apk add --no-cache libc6-compat\
        &&  wget https://github.com/google/cadvisor/releases/download/v0.37.0/cadvisor\
        &&  chmod +x cadvisor\
        &&  rm -f /var/cache/apk/*;
        
EXPOSE  8080

CMD     ["./cadvisor"]