
build:
	 docker build -t centos:weblogic .

run:
	docker stop weblogic || true
	docker run --rm -it -p5901:5901 -p8081:8080 -p5900:5900 -p6901:6901 --name weblogic centos:weblogic