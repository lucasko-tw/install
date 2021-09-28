```
mvn deploy:deploy-file 
 -DpomFile=/tmp/.m2/repository/commons-io/commons-io/2.1/commons-io-2.1.pom 
 -Dfile=/tmp/.m2/repository/commons-io/commons-io/2.1/commons-io-2.1.jar  
 -Durl=http://192.168.0.14:8081/repository/maven-releases/ 
 -DrepositoryId=my-repo
```

~/.m2/settings.xml

```xml
<settings>
  <servers>
    <server>
      <id>my-repo</id>
      <username>admin</username>
      <password>xxxxxx</password>
    </server>
  </servers>
</settings>

```




```py
import os
repo = "/Users/lucasko/m2"
for root, dirs, files in os.walk(repo):
    for file in files:
      if file.endswith(".pom"):
	pom = os.path.join(root, file)
	jar = pom.replace(".pom",".jar")
	command = "mvn deploy:deploy-file -Durl=http://192.168.0.14:8081/repository/maven-releases/  -DrepositoryId=my-repo  -DpomFile=$pom -Dfile=$jar"
	print command.replace("$jar",jar).replace("$pom",pom)
	#os.system(command)
```

