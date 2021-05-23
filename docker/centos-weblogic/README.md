# yum install --installroot=/tmp/yumrepo --releasever=/ --downloadonly --downloaddir=$(pwd)  --disableexcludes=all  java-1.8.0-openjdk 
docker run --rm -it -p5901:5901 -p8080:8080 -p5900:5900 -p6901:6901 centos:weblogic   


/opt/eclipse/eclipse  -application org.eclipse.equinox.p2.director  -repository https://download.eclipse.org/glassfish-tools/1.0.0/repository/  -installIU org.eclipse.glassfish.tools.feature.group



/opt/eclipse/eclipse  -application org.eclipse.equinox.p2.director  -repository https://download.eclipse.org/sapphire/9.1.1/repository/  -installIU org.eclipse.sapphire.feature.group

/opt/eclipse/eclipse  -application org.eclipse.equinox.p2.director  -repository https://download.eclipse.org/sapphire/9.1.1/repository/  -installIU org.eclipse.sapphire.java.feature.group
/opt/eclipse/eclipse  -application org.eclipse.equinox.p2.director  -repository https://download.eclipse.org/sapphire/9.1.1/repository/  -installIU org.eclipse.sapphire.java.jdt.feature.group

/opt/eclipse/eclipse  -application org.eclipse.equinox.p2.director  -repository http://download.oracle.com/otn_software/oepe/12.2.1.9/photon/repository/ -installIU oracle.eclipse.tools.weblogic.feature.group && \
/opt/eclipse/eclipse  -application org.eclipse.equinox.p2.director  -repository http://download.oracle.com/otn_software/oepe/12.2.1.9/photon/repository/ -installIU oracle.eclipse.tools.weblogic.scripting.feature.group
