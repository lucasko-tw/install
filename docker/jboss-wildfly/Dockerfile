From jboss/wildfly:8.2.1.Final

USER root
ENV TZ=Asia/Taipei

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY modules/module.xml  /opt/jboss/wildfly/modules/com/oracle/main/
COPY modules/ojdbc7.jar  /opt/jboss/wildfly/modules/com/oracle/main/
COPY standalone.xml      /opt/jboss/wildfly/standalone/configuration/

USER 1000

RUN /opt/jboss/wildfly/bin/add-user.sh lucas lucas1234 --silent

COPY ./war/my-web.war  /opt/jboss/wildfly/standalone/deployments/

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"  ]
