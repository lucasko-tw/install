

### show image details
```
docker history --format  "{{.CreatedBy}}" --no-trunc  48ac82184321 
```

### Weblogic

sudo docker run -it --name=wlsadmin --rm -p 7001:7001  wlsadmin:12.1.3

weblogic/lucas1234

sudo docker run -it --rm  --link wlsadmin:wlsadmin -e NM_HOST="192.168.1.188" -e NM_PORT="5558" oracle/weblogic:12.1.3-developer 



