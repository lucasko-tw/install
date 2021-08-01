### Weblogic

sudo docker run -it --name=wlsadmin --rm -p 7001:7001  wlsadmin:12.1.3

sudo docker run -it --rm  --link wlsadmin:wlsadmin -e NM_HOST="192.168.1.188" -e NM_PORT="5558" oracle/weblogic:12.1.3-developer 


### Oracle 
docker run --name oracle19c --memory 3g -p 1521:1521 -p 5500:5500 -e ORACLE_PDB=orcl -e ORACLE_PWD=1qaz@WSX1234 -e ORACLE_MEM=4000 -v $PWD/oradata:/opt/oracle/oradata  --rm -it oracle/database:19.3.0-ee


### Jboss Wilfly

### jboss - https://www3.ntu.edu.sg/home/ehchua/programming/java/JavaWebDBApp.html


docker run -it --rm -p 8080:8080 -p 9990:9990 --name myboss  jboss/wildfly:8.2.1.Final sh 

/opt/jboss/wildfly/bin/standalone.sh -bmanagement=0.0.0.0 -b 0.0.0.0

/opt/jboss/wildfly/bin/jboss-cli.sh --connect --controller=192.168.0.10:9990

/opt/jboss/wildfly/bin/add-user.sh

docker cp /Users/lucasko/code/docker/jboss-wildfly/ojdbc7.jar myboss:/tmp/

# Create JBOSS module with JDBC driver
module add --name=com.oracle --resources=/tmp/ojdbc7.jar --dependencies=javax.api,javax.transaction.api

# Create driver
/subsystem=datasources/jdbc-driver=oracle:add(driver-name="oracle",driver-module-name="com.oracle",driver-class-name=oracle.jdbc.driver.OracleDriver)

# Create datasource
data-source add --jndi-name=java:jboss/datasources/OracleDS --name=OraclePool --connection-url=jdbc:oracle:thin:@192.168.0.10:1521:orcl --driver-name=oracle --password=1qaz@WSX1234 --user-name=system

# Enable created datasource
data-source enable --name=OracleDS



### show image details
```
docker history --format  "{{.CreatedBy}}" --no-trunc  48ac82184321 
```

### Weblogic

sudo docker run -it --name=wlsadmin --rm -p 7001:7001  wlsadmin:12.1.3

weblogic/lucas1234

sudo docker run -it --rm  --link wlsadmin:wlsadmin -e NM_HOST="192.168.1.188" -e NM_PORT="5558" oracle/weblogic:12.1.3-developer 



### Archiva

docker run --name archiva --rm  -v /tmp/archiva-data:/archiva-data -uroot  -p 8080:8080 xetusoss/archiva 