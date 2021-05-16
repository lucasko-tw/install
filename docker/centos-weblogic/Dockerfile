FROM consol/centos-xfce-vnc
#FROM centos:7
#FROM centos:xfce
COPY ./eclipse-jee-photon-R-linux-gtk-x86_64_p.tar.gz /opt/

USER root
RUN groupadd -g 54321 oinstall							&& \
    useradd -u 54321 -g oinstall oracle					&& \
	mkdir -p /u01/app/oracle/product/					&& \
	mkdir -p /u01/app/oracle/config/domains				&& \
	mkdir -p /u01/app/oracle/config/applications		&& \
	chown -R oracle:oinstall /u01						&& \
	chmod -R 775 /u01								    && \
	rm -rf /etc/yum.repos.d/tigervnc.repo  				&& \
    yum install -y git unzip zip						&& \
    yum clean all -y										&& \
    cd /opt/ 											&& \
	tar zxvf eclipse-jee-photon-R-linux-gtk-x86_64_p.tar.gz && \
	rm -rf /opt/eclipse-jee-photon-R-linux-gtk-x86_64_p.tar.gz
#	/opt/eclipse/eclipse  -application org.eclipse.equinox.p2.director  -repository http://download.oracle.com/otn_software/oepe/12.2.1.9/photon/repository/ -installIU oracle.eclipse.tools.weblogic.feature.group && \
#	/opt/eclipse/eclipse  -application org.eclipse.equinox.p2.director  -repository http://download.oracle.com/otn_software/oepe/12.2.1.9/photon/repository/ -installIU oracle.eclipse.tools.weblogic.scripting.feature.group


ENV  ORACLE_BASE=/u01/app/oracle
ENV  ORACLE_HOME=$ORACLE_BASE/product/12.2.1.3
ENV  MW_HOME=$ORACLE_HOME
ENV  WLS_HOME=$MW_HOME/wlserver
ENV  WL_HOME=$WLS_HOME
ENV  DOMAIN_BASE=$ORACLE_BASE/config/domains
ENV  DOMAIN_HOME=$DOMAIN_BASE/mydomain
ENV  JAVA_HOME=/u01/app/oracle/jdk1.8.0_171
ENV  PATH=$JAVA_HOME/bin:$PATH


COPY ./fmw_12.2.1.3.0_wls_quick.jar /u01/app/oracle/product/
COPY ./jdk-8u171-linux-x64.tar.gz /tmp/
COPY ./sqldeveloper-20.4.1.407.0006-20.4.1-407.0006.noarch.rpm /tmp/
#COPY ./wls1036_dev.zip /u01/app/oracle/product/
USER oracle
RUN  tar -xvzf /tmp/jdk-8u171-linux-x64.tar.gz -C $ORACLE_BASE && \
  	 cd /u01/app/oracle/product/ && \
	 java -jar /u01/app/oracle/product/fmw_12.2.1.3.0_wls_quick.jar
# COPY ./create_domain.py     /u01/app/oracle/product/
# COPY ./myDomain.properties  /u01/app/oracle/product/

## install eclipse and weblogic plugins
USER root

RUN chown oracle:oinstall -R /opt && \
  	chown oracle:oinstall -R /u01 && \
	rm -rf /u01/app/oracle/product/fmw_12.2.1.3.0_wls_quick.jar && \
	rm -rf /tmp/jdk-8u171-linux-x64.tar.gz
	#rm -rf /tmp/sqldeveloper-20.4.1.407.0006-20.4.1-407.0006.noarch.rpm
