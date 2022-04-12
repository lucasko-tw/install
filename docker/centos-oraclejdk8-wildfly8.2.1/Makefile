IMAGE_VERSION=7.9-oraclejdk8-wildfly8.2.1
IMAGE_NAME=centos

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

run:
	docker run --rm -it $(IMAGE_NAME):$(IMAGE_VERSION) bash