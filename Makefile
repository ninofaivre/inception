all:
	sudo docker compose -f ./srcs/docker-compose.yaml build

start:
	sudo docker compose -f ./srcs/docker-compose.yaml up -d

stop:
	sudo docker compose -f ./srcs/docker-compose.yaml down

re: all stop start
