IMAGE = psunday/fake-backend:travis-ci

image:
	docker build -t $(IMAGE) .

run:
	docker run -d --name=fake-backend -p 80:80 $(IMAGE)
	# To let the container start before run test
	sleep 5

clean:
	docker rm -vf  fake-backend

push-image:
	docker push $(IMAGE)

.PHONY: image run test clean push-image
