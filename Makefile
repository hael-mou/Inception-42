# **************************************************************************** #
#                                                                              #
#         __ __         __    __  ___                                          #
#        / // /__ ____ / /   /  |/  /__  __ __                                 #
#       / _  / _ `/ -_) /   / /|_/ / _ \/ // /                                 #
#      /_//_/\_,_/\__/_/   /_/  /_/\___/\_,_/                                  #
#                                                                              #
#      | Makefile Dockerfile                                                   #
#      | By: hael-mou <hamzaelmoudden2@gmail.com>                              #
#      | Created: 2024/02/26                                                   #
#                                                                              #
# **************************************************************************** #

up:
	@docker-compose -f srcs/docker-compose.yml up -d --build;
	@docker system prune -f --volumes >/dev/null;

down:
	@docker-compose -f srcs/docker-compose.yml down

top:
	@docker-compose -f srcs/docker-compose.yml top;

ps:
	@docker-compose -f srcs/docker-compose.yml ps --all;

images:
	@docker images -a;

clean:
	@if [ -n "$(shell docker ps -q)" ]; then\
		docker stop $(shell docker ps -q)\
		&& docker rm $(shell docker ps -q) > /dev/null;\
	fi;
	@if [ -n "$(shell docker images -aq)" ]; then\
		docker rmi	 $(shell docker images -aq) > /dev/null;\
	fi;
	@if [ -n "$(shell docker network ls -q)" ]; then\
		docker network rm $(shell docker network ls -q) 2> /dev/null\
		|| (exit 0);\
	fi;
	@if [ -n "$(shell docker volume ls -q)" ]; then\
		docker volume rm $(shell docker volume ls -q) > /dev/null;\
	fi;

.PHONY: up down top ps images clean