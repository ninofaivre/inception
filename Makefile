all:
	sudo docker volume create wordpressFiles
	sudo docker volume create wordpressDB
	sudo docker compose -f ./srcs/docker-compose.yaml build

start:
	sudo docker compose -f ./srcs/docker-compose.yaml up -d

stop:
	sudo docker compose -f ./srcs/docker-compose.yaml down

re: all stop start

ps:
	sudo docker compose -f ./srcs/docker-compose.yaml ps

reset:
	- sudo docker stop $(shell sudo docker ps -qa)
	- sudo docker rm $(shell sudo docker ps -qa)
	- sudo docker rmi -f $(shell sudo docker images -qa)
	- sudo docker volume rm $(shell sudo docker volume ls -q)
	- sudo docker network rm $(shell sudo docker network ls -q) 2>/dev/null
