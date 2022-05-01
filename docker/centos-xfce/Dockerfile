FROM centos:7

ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901
EXPOSE $VNC_PORT $NO_VNC_PORT

EXPOSE $VNC_PORT

ENV HOME=/comics \
    VNC_RES=1280x1024 \
    VNC_COL_DEPTH=24 \
    VNC_PSSWRD=lucas1234 \
    VNC_VIEWONLY=false

### Envrionment config
ENV HOME=/user01 \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/user01/install \
    NO_VNC_HOME=/user01/noVNC \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x1024 \
    VNC_PW=vncpassword \
    VNC_VIEW_ONLY=false


WORKDIR $HOME

USER root
RUN yum install -y epel-release ; \
    yum install -y git     \
                   make    \
                   vim	   \
                   net-tools \
                   nss_wrapper \
                   sudo \
                   tigervnc-server-minimal \
                   x11vnc \
                   xinetd \
                   which ; \
    yum groups install -y Xfce ; \
    yum -y groups install "Fonts" ; \
    yum erase -y *power* *screensaver* ; \
    rm /etc/xdg/autostart/xfce-polkit* ; \
    /bin/dbus-uuidgen > /etc/machine-id ; \
    yum clean all ;

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh


ENTRYPOINT ["/bin/bash","/usr/local/bin/docker-entrypoint.sh"]