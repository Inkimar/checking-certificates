#! make

up:
	@docker-compose up -d

ps:
	@docker-compose ps

down:
	@docker-compose down
