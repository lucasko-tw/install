build:
	./buildDockerImage.sh -v 19.3.0 -x
	#./buildDockerImage.sh -v 11.2.0.2 -x

run:
	docker run -it --name oracle19c --memory 3g -p 1521:1521 -p 5500:5500  && \
	--rm && \
	-e ORACLE_PDB=orcl && \
	-e ORACLE_PWD=1qaz@WSX1234 && \
	-e ORACLE_MEM=3000   && \
	-it oracle/database:19.3.0-ee