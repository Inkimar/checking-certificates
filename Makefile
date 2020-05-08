#! make

up:
	@docker-compose up -d

ps:
	@docker-compose ps

down:
	@docker-compose down

up-test:
	@docker-compose -f docker-compose.2020.yml up 

ps-test:
	@docker-compose -f docker-compose.2020.yml ps 

down-test:
	@docker-compose -f docker-compose.2020.yml down


ping-nrm-local:
	@ping local.nrm.se

ping-naturforskaren-local:
	@ping local.naturforskaren.se