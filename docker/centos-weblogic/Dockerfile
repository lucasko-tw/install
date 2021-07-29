FROM consol/centos-xfce-vnc
#FROM centos:7
#FROM centos:xfce

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
    yum clean all -y

ENV  ORACLE_BASE=/u01/app/oracle
ENV  ORACLE_HOME=$ORACLE_BASE/product/12.2.1.3
ENV  MW_HOME=$ORACLE_HOME
ENV  WLS_HOME=$MW_HOME/wlserver
ENV  WL_HOME=$WLS_HOME
ENV  DOMAIN_BASE=$ORACLE_BASE/config/domains
ENV  DOMAIN_HOME=$DOMAIN_BASE/mydomain
ENV  JAVA_HOME=/u01/app/oracle/jdk1.8.0_171
ENV  PATH=$JAVA_HOME/bin:$PATH

# Install OpenJDK
#COPY ./centos7-openjdk-rpm.tar /tmp/
#RUN  cd /tmp/	&& \
#     wget http://mirror.centos.org/centos/7/os/x86_64/Packages/glib2-2.56.1-7.el7.x86_64.rpm  && \
#     yum localinstall -y glib2-2.56.1-7.el7.x86_64.rpm && \
#	 tar zxvf /tmp/centos7-openjdk-rpm.tar  && \
#	 rpm -ivh /tmp/centos7-openjdk-rpm/*.rpm


# Install Oracle JDK
COPY ./jdk-8u171-linux-x64.tar.gz /tmp/
USER root
RUN  tar -xvzf /tmp/jdk-8u171-linux-x64.tar.gz -C $ORACLE_BASE
RUN chown oracle:oinstall -R /opt/ & \
    chown oracle:oinstall -R $ORACLE_BASE


COPY ./oepe-12.2.1.9-photon-distro-linux-gtk-x86_64.zip /opt/eclipse/
RUN cd /opt/eclipse && \
	unzip oepe-12.2.1.9-photon-distro-linux-gtk-x86_64.zip && \
	rm -rf /opt/eclipse/oepe-12.2.1.9-photon-distro-linux-gtk-x86_64.zip

#
# COPY ./sqldeveloper-20.4.1.407.0006-20.4.1-407.0006.noarch.rpm /tmp/
# RUN rpm -Uvh /tmp/sqldeveloper-20.4.1.407.0006-20.4.1-407.0006.noarch.rpm  & \
# 	rm -rf /tmp/sqldeveloper-20.4.1.407.0006-20.4.1-407.0006.noarch.rpm


# # Install Weblogic 12.2.1.3
# USER oracle
# COPY ./fmw_12.2.1.3.0_wls_quick.jar /u01/app/oracle/product/
# RUN  cd /u01/app/oracle/product/ && \
# 	 java -jar /u01/app/oracle/product/fmw_12.2.1.3.0_wls_quick.jar
#
# ## install eclipse and weblogic plugins
# USER root
# RUN chown oracle:oinstall -R /opt && \
#   	chown oracle:oinstall -R /u01 && \
# 	rm -rf /u01/app/oracle/product/fmw_12.2.1.3.0_wls_quick.jar

COPY ./wls1033_dev/      /opt/wls1033_dev/
COPY ./user_projects.tar /opt/wls1033_dev/
env MW_HOME=/opt/wls1033_dev
RUN /opt/wls1033_dev/configure.sh && \
	tar zxvf /opt/wls1033_dev/user_projects.tar -C /opt/wls1033_dev/

COPY ./zulu6.22.0.3-jdk6.0.119-linux_x64.tar.gz /tmp/
RUN tar zxvf /tmp/zulu6.22.0.3-jdk6.0.119-linux_x64.tar.gz -C /opt/ && \
	rm -rf /tmp/zulu6.22.0.3-jdk6.0.119-linux_x64.tar.gz
