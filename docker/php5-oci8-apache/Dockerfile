FROM php:5.5-apache

RUN apt-get update	 && \
 	apt-get install -y unzip libaio-dev php5-dev	 && \
 	apt-get clean -y

# Oracle instantclient
ADD instantclient-basic-linux.x64-12.1.0.2.0.zip /tmp/
ADD instantclient-sdk-linux.x64-12.1.0.2.0.zip /tmp/
ADD instantclient-sqlplus-linux.x64-12.1.0.2.0.zip /tmp/

RUN unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /usr/local/	 && \
 	unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /usr/local/	 && \
 	unzip /tmp/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip -d /usr/local/ && \
 	ln -s /usr/local/instantclient_12_1 /usr/local/instantclient			 && \
 	ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so	&& \
 	ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus

RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8-2.0.12 && \
 	mkdir -p /etc/php5/apache2/conf.d/ && \
    echo "extension=oci8.so" > /etc/php5/apache2/conf.d/30-oci8.ini && \
    rm -rf /tmp/instantclient*