 docker run -it --rm -v ~/reposilite/data:/app/data -p 80:80 -e REPOSILITE_OPTS='--config=/app/data/my_reposilite.cdn' --name repo  dzikoysk/reposilite:nightly sh
 
 
 my_reposilite.cdn
 
```properties
# ~~~~~~~~~~~~~~~~~~~~~~ #
#       Reposilite       #
# ~~~~~~~~~~~~~~~~~~~~~~ #

# Hostname
hostname: 0.0.0.0
# Port to bind
port: 80
# Custom base path
basePath: /
# Any kind of proxy services change real ip.
# The origin ip should be available in one of the headers.
# Nginx: X-Forwarded-For
# Cloudflare: CF-Connecting-IP
# Popular: X-Real-IP
forwardedIp: X-Forwarded-For
# Enable Swagger (/swagger-docs) and Swagger UI (/swagger)
swagger: false
# Debug
debugEnabled: false

# Support encrypted connections
sslEnabled: false
# SSL port to bind
sslPort: 443
# Key store file to use.
# You can specify absolute path to the given file or use ${WORKING_DIRECTORY} variable.
keyStorePath: ${WORKING_DIRECTORY}/keystore.jks
# Key store password to use
keyStorePassword: ""
# Redirect http traffic to https
enforceSsl: false

# Control the maximum amount of data assigned to Reposilite instance
# Supported formats: 90%, 500MB, 10GB
diskQuota: 10GB
# List of supported Maven repositories.
# First directory on the list is the main (primary) repository.
# Tu mark repository as private, prefix its name with a dot, e.g. ".private"
repositories [
  releases
  snapshots
]
# Allow to omit name of the main repository in request
# e.g. /org/panda-lang/reposilite will be redirected to /releases/org/panda-lang/reposilite
rewritePathsEnabled: true
# Accept deployment connections
deployEnabled: true

# List of proxied repositories.
# Reposilite will search for an artifact in remote repositories listed below,
# if the requested artifact was not found.
proxied [
  https://repo.maven.apache.org/maven2
]
# Reposilite can store proxied artifacts locally to reduce response time and improve stability
storeProxied: true
# Proxying is disabled by default in private repositories because of the security policy.
# Enabling this feature may expose private data like i.e. artifact name used in your company.
proxyPrivate: false
# How long Reposilite can wait for establishing the connection with a remote host. (In seconds)
proxyConnectTimeout: 3
# How long Reposilite can read data from remote proxy. (In seconds)
# Increasing this value may be required in case of proxying slow remote repositories.
proxyReadTimeout: 15

# Title displayed by frontend
title: #onlypanda
# Description displayed by frontend
description: Public Maven repository hosted through the Reposilite
# Accent color used by frontend
accentColor: #2fd4aa%   
```

```groovy
buildscript {
    repositories {
       maven{
           url "http://localhost/releases"
       }
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:2.1.0.RELEASE")
    }
}
```