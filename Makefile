
DOCKER_COMPOSE_FILE =	srcs/docker-compose.yml
WP_VOLUME_FILE =        /home/gpaupher/data/wordpress
DB_VOLUME_FILE =		/home/gpaupher/data/mariadb
ENV_SRC =				/home/gpaupher/42/annexe/env
CURRENT_DIR =           $(shell pwd)
ENV_DST =               $(CURRENT_DIR)/srcs/.env

all: build up

macos:
		sudo echo "127.0.0.1 gpaupher.42.fr" >> /etc/hosts
		sudo echo "127.0.0.1 www.gpaupher.42.fr" >> /etc/hosts

env:
		cp ${ENV_SRC} ${ENV_DST}

rm-env:
		sudo rm ${ENV_DST}

ps:		@docker compose -f ${DOCKER_COMPOSE_FILE} ps -a

build: 
		mkdir -p $(WP_VOLUME_FILE)
		mkdir -p $(DB_VOLUME_FILE)
		@docker compose -f $(DOCKER_COMPOSE_FILE) build

up:
		@docker compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
		@docker compose -f $(DOCKER_COMPOSE_FILE) down

stop:
		@docker compose -f $(DOCKER_COMPOSE_FILE) stop

clean:	down
		sudo rm -rf $(WP_VOLUME_FILE)
		sudo rm -rf $(DB_VOLUME_FILE)
		@docker container prune --force

fclean: clean
		@docker system prune -af

re:		fclean all

.PHONY	: all build up down stop clean fclean re