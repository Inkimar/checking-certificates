#! make



up-nrm:
	@docker-compose -f docker-compose.nrm.yml up 

ps-nrm:
	@docker-compose -f docker-compose.nrm.yml ps 

down-nrm:
	@docker-compose -f docker-compose.nrm.yml down


up-natur:
	@docker-compose -f docker-compose.naturforskaren.yml up 

ps-natur:
	@docker-compose -f docker-compose.naturforskaren.yml ps 

down-natur:
	@docker-compose -f docker-compose.naturforskaren.yml down

# update your /etc/hosts with 127.0.0.1 -> local.nrm.se and local.naturforskaren.se
ping-nrm-local:
	@ping local.nrm.se

ping-naturforskaren-local:
	@ping local.naturforskaren.se

curl-nrm:
	@curl -L local.nrm.se

curl-natur:
	@curl -L local.naturforskaren.se