FROM consol/centos-xfce-vnc
#FROM centos:7
#FROM centos:xfce

user root
RUN groupadd -g 54321 oinstall							&& \
    useradd -u 54321 -g oinstall oracle					&& \
	mkdir -p /u01/app/oracle/product/		&& \
	mkdir -p /u01/app/oracle/config/domains				&& \
	mkdir -p /u01/app/oracle/config/applications		&& \
	chown -R oracle:oinstall /u01						&& \
	chmod -R 775 /u01/




ENV  ORACLE_BASE=/u01/app/oracle
ENV  ORACLE_HOME=$ORACLE_BASE/product/12.2.1.3
ENV  MW_HOME=$ORACLE_HOME
ENV  WLS_HOME=$MW_HOME/wlserver
ENV  WL_HOME=$WLS_HOME
ENV  DOMAIN_BASE=$ORACLE_BASE/config/domains
ENV  DOMAIN_HOME=$DOMAIN_BASE/mydomain
ENV  JAVA_HOME=/u01/app/oracle/jdk1.8.0_151
ENV  PATH=$JAVA_HOME/bin:$PATH

COPY ./fmw_12.2.1.3.0_wls_quick.jar /u01/app/oracle/product/
COPY ./jdk-8u151-linux-x64.tar.gz /tmp/

USER oracle
RUN  tar -xvzf /tmp/jdk-8u151-linux-x64.tar.gz -C $ORACLE_BASE
RUN  cd /u01/app/oracle/product/ && \
	 java -jar /u01/app/oracle/product/fmw_12.2.1.3.0_wls_quick.jar

 COPY ./create_domain.py     /u01/app/oracle/product/
 COPY ./myDomain.properties  /u01/app/oracle/product/

RUN yum install -y git

USER root
RUN chown oracle:oinstall -R /opt/

