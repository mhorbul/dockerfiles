FROM mhorbul/rbenv

ENV PERCONA_MYSQL_VERSION 56

RUN rpm --import http://www.percona.com/downloads/RPM-GPG-KEY-percona
RUN yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
RUN yum install -y Percona-Server-devel-$PERCONA_MYSQL_VERSION openssl-devel

RUN bash -lc 'rbenv install 2.1.4'
RUN bash -lc 'rbenv global 2.1.4'
RUN bash -lc 'gem install bundler --no-ri --no-rdoc'