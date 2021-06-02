FROM centos:7.9.2009
#RUN  yum update -y && \
#     yum install unzip -y

#ENV CATALINA_HOME /usr/local/tomcat

ADD java-1.8.0-openjdk-1.8.0.262.b10-1.el7.x86_64.rpm /tmp/openjdk.rpm

RUN yum localinstall -y  /tmp/openjdk.rpm


