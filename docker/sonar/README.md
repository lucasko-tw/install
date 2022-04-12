1. GUI admin / admin

2. Administrator -> my Acount -> security -> Generate Tokens

docker run --rm  -e SONAR_HOST_URL=http://192.168.1.188:9000  -e SONAR_LOGIN=d72bf1c637cd9b95899192a97b33454b94a8da14    -v $PWD:/usr/src sonarsource/sonar-scanner-cli -Dsonar.projectKey=myproject