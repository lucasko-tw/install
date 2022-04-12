FROM centos:7.9.2009


USER root

ENV  JAVA_HOME=/opt/jdk1.8.0_171
ENV  PATH=$JAVA_HOME/bin:$PATH

# Install Oracle JDK
COPY ./jdk-8u171-linux-x64.tar.gz /tmp/
RUN  tar -xvzf /tmp/jdk-8u171-linux-x64.tar.gz -C /opt

# Install Wildfly
COPY ./wildfly-8.2.1.Final.tar.gz /tmp/
RUN  tar -xvzf /tmp/wildfly-8.2.1.Final.tar.gz -C /opt
RUN /opt/wildfly-8.2.1.Final/bin/add-user.sh lucas lucas1234 --silent

CMD ["/opt/wildfly-8.2.1.Final/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"  ]
