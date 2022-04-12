
sudo mkdir /opt/openvpn
sudo chown 1000:1000 /opt/openvpn
export OVPN_DATA=/opt/openvpn
docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://54.170.225.132

```
# change to server IP
docker-compose run --rm ovpn ovpn_genconfig -u udp://$YOUR_IP_ADDRESS
docker-compose run --rm ovpn ovpn_initpki
docker-compose up -d

#create CA
docker-compose run --rm ovpn easyrsa build-client-full "$CLIENTNAME" nopass
#export
docker-compose run --rm ovpn ovpn_getclient "$CLIENTNAME" > "$CLIENTNAME.ovpn"
```