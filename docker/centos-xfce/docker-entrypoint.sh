#!/bin/bash

function start_vnc {
  xinetd
  if [[ ! -z ${VNCPASSWORD+x} ]] ; then
    su -l $DEFAULT_USER -c "x11vnc -storepasswd $VNCPASSWORD ~/vnc.pass"
    su -l $DEFAULT_USER -c "export PATH=$PATH ; x11vnc -xvnc -ncache 10 -env FD_PROG=/usr/bin/xfce4-session -gone 'killall xfce4' -bg -rfbauth ~/vnc.pass"
  else
    su -l $DEFAULT_USER -c "export PATH=$PATH ;  x11vnc -xvnc -ncache 10 -env FD_PROG=/usr/bin/xfce4-session -gone 'killall xfce4' -bg -nopw"
  fi
}

if [[ ! -z ${HOST_USER_ID+x} &&  ! -z ${HOST_GROUP_ID+x} ]] ; then
   groupadd -g $HOST_GROUP_ID -f user
   useradd -m -s /bin/bash -u $HOST_USER_ID  -g $HOST_GROUP_ID user
   sed -i '/^root/a user    ALL=(ALL)       NOPASSWD: ALL'  /etc/sudoers

   DEFAULT_USER=user
   start_vnc

   /usr/local/sbin/gosu user "$@"
   exit 0
else
 DEFAULT_USER=root
 start_vnc
 exec "$@"
fi

echo "sleeping..."
sleep 10000