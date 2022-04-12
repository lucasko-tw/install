IMAGE_VERSION=20220412
IMAGE_NAME=cloudos

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

run:
	docker run --rm -it $(IMAGE_NAME):$(IMAGE_VERSION) bash

run:
	docker stop cloudos || true
	docker run --rm -it -p5901:5901 -p8081:8080 -p5900:5900 -p6901:6901 --name cloudos $(IMAGE_NAME):$(IMAGE_VERSION)