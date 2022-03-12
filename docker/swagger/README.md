
## editor
 docker run -d -p 81:8080 swaggerapi/swagger-editor
 
 to download swagger.yaml
 
 ## deploy
 ocker run --rm -it -p 80:8080 -v ~/Downloads/swagger.yaml:/usr/share/nginx/html/config/openapi.yaml swaggerapi/swagger-ui