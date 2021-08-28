up: fpm.yml ludo.yml nginx.yml mysql.yml
	@docker-compose -f ludo.yml -f fpm.yml -f nginx.yml -f mysql.yml up -d
down: fpm.yml ludo.yml nginx.yml mysql.yml
	@docker-compose -f ludo.yml -f fpm.yml -f nginx.yml -f mysql.yml down

network-up:
	docker network create -d bridge --subnet 172.24.0.0/16 backend
	docker network create -d bridge --subnet 172.25.0.0/16 frontend
network-down:
	docker network rm frontend backend

fpm-up:
	@docker-compose -f fpm.yml up -d
fpm-down:
	@docker-compose -f fpm.yml down
fpm-restart:
	@docker-compose -f fpm.yml restart

ludo-up:
	@docker-compose -f ludo.yml up -d
ludo-down:
	@docker-compose -f ludo.yml down
ludo-restart:
	@docker-compose -f ludo.yml restart

nginx-up:
	@docker-compose -f nginx.yml up -d
nginx-down:
	@docker-compose -f nginx.yml down
nginx-restart:
	@docker-compose -f nginx.yml restart

mysql-up:
	@docker-compose -f mysql.yml up -d
mysql-down:
	@docker-compose -f mysql.yml down
mysql-restart:
	@docker-compose -f mysql.yml restart
