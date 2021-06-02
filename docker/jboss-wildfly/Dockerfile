From jboss/wildfly:8.2.1.Final

USER root

ENV TZ=Asia/Taipei

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#telnet
RUN yum install -y iputils  htop vim vmstat lsof	

USER 1000