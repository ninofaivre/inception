include ./srcs/.env

all:
	$(shell if ! cat /etc/hosts | grep -q ${LOGIN}; then echo "127.0.0.1  ${LOGIN}.42.${EXT}" >> /etc/hosts; echo "127.0.0.1  www.${LOGIN}.42.${EXT}" >> /etc/hosts; fi)
	mkdir -p /home/${LOGIN}/data
	mkdir -p /home/${LOGIN}/data/wordpressFiles
	mkdir -p /home/${LOGIN}/data/wordpressDB
	docker-compose --project-directory ./srcs build

start:
	docker-compose --project-directory ./srcs up --no-build -d

stop:
	docker-compose --project-directory ./srcs down

re: reset all

reset:
	- docker stop $(shell docker ps -qa) >/dev/null 2>&1
	- docker rm $(shell docker ps -qa) >/dev/null 2>&1
	- docker rmi -f $(shell docker images -qa) >/dev/null 2>&1
	- docker volume rm $(shell docker volume ls -q) >/dev/null 2>&1
	- docker network rm $(shell docker network ls -q) >/dev/null 2>&1
	- rm -rf /home/${LOGIN}/data
	- $(shell sed "/${LOGIN}.42.${EXT}/d" /etc/hosts -i)
