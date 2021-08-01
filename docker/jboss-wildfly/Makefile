

build:
	docker build -t wildfly:lucas .

run:
	docker stop myjboss || true
	docker run --name myjboss --rm -it -p 8080:8080 -p 9990:9990  wildfly:lucas

backup:
	docker cp myboss:/opt/jboss/wildfly/standalone/configuration/standalone.xml ./
	docker cp myboss:/opt/jboss/wildfly/modules/com/oracle/main/module.xml ./modules/
	docker cp myboss:/opt/jboss/wildfly/modules/com/oracle/main/ojdbc7.jar ./modules/