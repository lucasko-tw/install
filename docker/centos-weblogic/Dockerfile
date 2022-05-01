#FROM consol/centos-xfce-vnc
#FROM centos:7
FROM centos:novnc

USER root
RUN rm -rf /etc/yum.repos.d/tigervnc.repo			&& \
	yum install -y git unzip zip telnet ftp rsync gzip vim wget rsh make vim spawn expect && \
	yum clean all -y

# ENV  ORACLE_BASE=/opt/oracle
# ENV  ORACLE_HOME=$ORACLE_BASE/product/12.2.1.3
# ENV  MW_HOME=$ORACLE_HOME
# ENV  WLS_HOME=$MW_HOME/wlserver
# ENV  WL_HOME=$WLS_HOME
# ENV  DOMAIN_BASE=$ORACLE_BASE/config/domains
# ENV  DOMAIN_HOME=$DOMAIN_BASE/mydomain
# ENV  JAVA_HOME=/opt/oracle/jdk1.8.0_171
# ENV  PATH=$JAVA_HOME/bin:$PATH


# Install Oracle JDK
# COPY ./jdk-8u171-linux-x64.tar.gz /tmp/
# USER root
# RUN  tar -xvzf /tmp/jdk-8u171-linux-x64.tar.gz -C $ORACLE_BASE
# RUN chown user01:user01 -R /opt/ & \
#     chown user01:user01 -R $ORACLE_BASE & \
#     rm -rf /tmp/jdk-8u171-linux-x64.tar.gz


#
# COPY ./sqldeveloper-20.4.1.407.0006-20.4.1-407.0006.noarch.rpm /tmp/
# RUN rpm -Uvh /tmp/sqldeveloper-20.4.1.407.0006-20.4.1-407.0006.noarch.rpm  & \
# 	rm -rf /tmp/sqldeveloper-20.4.1.407.0006-20.4.1-407.0006.noarch.rpm

# # Install Weblogic 12.2.1.3
# USER 1000
# COPY ./fmw_12.2.1.3.0_wls_quick.jar /opt/oracle/product/
# RUN  cd /opt/oracle/product/ && \
# java -jar /opt/oracle/product/fmw_12.2.1.3.0_wls_quick.jar



# Install OpenJDK
# COPY ./centos7-openjdk-rpm.tar /tmp/
# RUN  cd /tmp/	&& \
#     wget http://mirror.centos.org/centos/7/os/x86_64/Packages/glib2-2.56.1-7.el7.x86_64.rpm  && \
#     yum localinstall -y glib2-2.56.1-7.el7.x86_64.rpm && \
# 	 tar zxvf /tmp/centos7-openjdk-rpm.tar  && \
# 	 rpm -ivh /tmp/centos7-openjdk-rpm/*.rpm

#Install OpenJDK
RUN yum install -y java-1.8.0-openjdk

# # Install Weblogic 10.3.6
# USER 1000
COPY ./wls1036_generic.jar /opt/
COPY ./install_wls.sh /opt/
COPY ./create_domain.sh /opt/
RUN  cd /opt/ && expect ./install_wls.sh && \
 	 mkdir /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-1.el7_9.x86_64/bin	&& \
     ln -s /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-1.el7_9.x86_64/jre/bin/java /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-1.el7_9.x86_64/bin/java && \
	 rm -rf /opt/wls1036_generic.jar	&& \
	 /opt/create_domain.sh				&& \
	 sed -i 's/x86_64/x86_64\/jre/' /opt/Oracle/Middleware/user_projects/domains/base_domain/bin/setDomainEnv.sh  && \
	 rm -rf /opt/create_domain.sh


USER root
# Install Eclipse
COPY ./oepe-12.2.1.9-photon-distro-linux-gtk-x86_64.zip /opt/eclipse/
COPY ./eclipse.desktop /user01/Desktop/
RUN cd /opt/eclipse && \
	unzip oepe-12.2.1.9-photon-distro-linux-gtk-x86_64.zip && \
	rm -rf /opt/eclipse/oepe-12.2.1.9-photon-distro-linux-gtk-x86_64.zip

# # Post install
RUN groupadd -g 1000 user01				 && \
    useradd -u 1000 -g user01 user01	 && \
    mkdir /user01/Desktop/code			 && \
    chown 1000:1000 -R /opt 			 && \
    chown 1000:1000 -R /user01 			 && \
    rm -rf /opt/install_wls.sh

#ENV HOME=/home/user01
USER 1000
