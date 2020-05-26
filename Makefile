IMAGE = psunday/fake-backend:travis-ci


network: 
	docker network create  fbk_network

volume:
	docker volume create mysql_data


image:
	docker build -t $(IMAGE) .

run:
        docker run --name dbgame -d -v mysql_data:/var/lib/mysql -p 3306:3306 -e  MYSQL_ROOT_PASSWORD=rootpwdpsu -e  MYSQL_DATABASE=batt         leboat -e MYSQL_USER=battleuser -e  MYSQL_PASSWORD=battlepass --network fbk_network  mysql:5.7
	sleep 3s

	docker run --name battlegame -d -v ${PWD}/battleboat:/etc/backend/static -p 3000:3000 -e  DATABASE_HOST=dbpsu -e  DATABASE_PORT=         3306 -e  DATABASE_USER=battleuser -e DATABASE_PASSWORD=battlepass -e DATABASE_NAME=battleboat  --network fbk_network  $(IMAGE)


	# To let the container start before run test
	sleep 5
        docker ps -a 
test:

	if [ "$$(curl -X GET http://127.0.0.1:3000/health)" = "200" ]; then echo "test OK"; exit 0; else echo "test KO"; exit 1; fi
	echo "fin test"

clean:
	docker rm -vf  fake-backend

push-image:
	docker push $(IMAGE)

.PHONY: image run test clean push-image
