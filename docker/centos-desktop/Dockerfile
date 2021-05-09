FROM centos:7
RUN yum install epel-release -y

RUN yum groupinstall "Server with GUI" -y

RUN yum groupinstall "Xfce" -y

RUN systemctl get-default

RUN systemctl set-default graphical.target

RUN systemctl get-default

RUN yum install -y tigervnc-server tigervnc vnc vnc-server



