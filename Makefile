run:
	docker-compose up -d --build nginx mysql5.7 php7.4 php7.3 php5.6

cli-5.6: run
	docker exec -it php5.6 bash

cli-7.3: run
	docker exec -it php7.3 bash

cli-7.4: run
	docker exec -it php7.4 bash
