FROM centos:centos6

ENV PERCONA_MYSQL_VERSION 56

RUN rpm --import http://www.percona.com/downloads/RPM-GPG-KEY-percona
RUN yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
RUN yum install -y Percona-Server-client-$PERCONA_MYSQL_VERSION \
                   Percona-Server-devel-$PERCONA_MYSQL_VERSION \
                   Percona-Server-server-$PERCONA_MYSQL_VERSION \
                   Percona-Server-shared-$PERCONA_MYSQL_VERSION

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/etc/mysql", "/var/lib/mysql"]

CMD ["mysqld_safe"]

EXPOSE 3306

# hack for OSX to make /data volume writable for mysql user
RUN usermod -u 1000 mysql