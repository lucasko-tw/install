## start a linux container with vnc & novnc
docker run --rm  -p 5901:5901 consol/centos-xfce-vnc


## start a novnc
docker run --rm --name novnc -p 6080:6080 -e AUTOCONNECT=true -e VNC_PASSWORD=vncpassword -e VNC_SERVER=192.168.0.12:5901 -e VIEW_ONLY=false bonigarcia/novnc:1.1.0

