build:
	docker build -t php:5.5-oci8-2.0.12-apache .

run/php:
	docker run -it --rm -v $$(PWD)/html/:/var/www/html/ -p 80:80 php:5.5-oci8-2.0.12-apache

run/oracle:
	 docker run --name oracle19c --memory 3g -p 1521:1521 -p 5500:5500 -e ORACLE_PDB=orcl -e ORACLE_PWD=1qaz@WSX1234 -e ORACLE_MEM=4000   --rm -it oracle/database:19.3.0-ee