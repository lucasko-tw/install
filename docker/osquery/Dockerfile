FROM centos:7

#ADD https://pkg.osquery.io/rpm/osquery-5.2.2-1.linux.x86_64.rpm /tmp/
COPY osquery-5.2.2-1.linux.x86_64.rpm /tmp/

RUN rpm -ivh /tmp/osquery-5.2.2-1.linux.x86_64.rpm

# Copy the default osquery.conf (However, a custom conf should be specified
# with `docker run -v osquery.conf:/etc/osquery.conf zwass/osqueryd`
COPY osquery.example.conf /etc/osquery/osquery.conf

CMD ["osqueryd", "--config_path=/etc/osquery/osquery.conf", "--verbose"]