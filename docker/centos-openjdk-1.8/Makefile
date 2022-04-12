IMAGE_VERSION=7.9-openjdk-1.8
IMAGE_NAME=centos

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

run:
	docker run --rm -it $(IMAGE_NAME):$(IMAGE_VERSION) bash